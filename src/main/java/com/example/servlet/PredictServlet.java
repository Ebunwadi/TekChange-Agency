package com.example.servlet;

import weka.classifiers.Classifier;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.converters.ArffLoader;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;

@WebServlet("/predict")
public class PredictServlet extends HttpServlet {

    private Classifier model;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            // Load the saved WEKA model
            File modelFile = new File(getServletContext().getRealPath("//WEB-INF//items.model"));
            model = (Classifier) weka.core.SerializationHelper.read(modelFile.getAbsolutePath());
        } catch (Exception e) {
            throw new ServletException("Failed to load model", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Forward to the form.jsp page
        req.getRequestDispatcher("/predict.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Create an instance with user-provided values
            Instances data = createInstances();
            Instance instance = createInstance(req, data);

            // Make a prediction
            double prediction = model.classifyInstance(instance);
            String predictedCategory = data.classAttribute().value((int) prediction);

            // Set the result and forward to JSP
            req.setAttribute("predictedCategory", predictedCategory);
            req.getRequestDispatcher("/result.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException("Prediction failed", e);
        }
    }

    private Instances createInstances() throws Exception {
        ArffLoader loader = new ArffLoader();
        File dataFile = new File(getServletContext().getRealPath("//WEB-INF//items.arff"));
        if (!dataFile.exists()) {
            throw new ServletException("ARFF file not found at " + dataFile.getAbsolutePath());
        }
        loader.setFile(dataFile);
        Instances data = loader.getDataSet();
        data.setClassIndex(data.numAttributes() - 1);
        return data;
    }

    private Instance createInstance(HttpServletRequest req, Instances data) {
        Instance instance = new weka.core.DenseInstance(data.numAttributes());
        instance.setDataset(data);

        setAttributeValue(instance, data, "Brand", req.getParameter("brand"));
        setAttributeValue(instance, data, "RAM", req.getParameter("ram"));
        setAttributeValue(instance, data, "Model", req.getParameter("model"));
        setAttributeValue(instance, data, "Size", req.getParameter("size"));
        setAttributeValue(instance, data, "Type", req.getParameter("type"));
        setAttributeValue(instance, data, "Colour", req.getParameter("colour"));

        return instance;
    }

    private void setAttributeValue(Instance instance, Instances data, String attributeName, String value) {
        System.out.println("Setting attribute: " + attributeName + " with value: " + value);
        if (value != null && !value.isEmpty()) {
            instance.setValue(data.attribute(attributeName), value);
        } else {
            System.out.println("Value for " + attributeName + " is null or empty");
            // Handle missing value by setting it as missing
            instance.setMissing(data.attribute(attributeName));
        }
    }
}
