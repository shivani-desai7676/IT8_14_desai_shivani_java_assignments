<%-- 
    Document   : index
    Created on : 05-Mar-2026, 11:17:13 am
    Author     : root
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Currency Converter Pro</title>
    <style>
        /* Modern UI Styling */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f7f6;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .converter-card {
            background: #ffffff;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            width: 350px;
        }

        h2 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .input-group {
            margin-bottom: 1rem;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: 600;
            color: #555;
        }

        input[type="number"], input[type="text"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
            box-sizing: border-box; /* Ensures padding doesn't break width */
        }

        input:focus {
            border-color: #3498db;
            outline: none;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s;
        }

        button:hover {
            background-color: #2980b9;
        }

        .result-box {
            margin-top: 1.5rem;
            padding: 15px;
            border-radius: 6px;
            text-align: center;
            font-weight: bold;
        }

        .success {
            background-color: #e8f5e9;
            color: #2e7d32;
            border: 1px solid #c8e6c9;
        }

        .error {
            background-color: #ffebee;
            color: #c62828;
            border: 1px solid #ffcdd2;
        }
    </style>
</head>
<body>

<div class="converter-card">
    <h2>Currency Converter</h2>
    
    <form action="Currency" method="POST">
        <div class="input-group">
            <label>Amount</label>
            <input type="number" step="0.01" name="amount" placeholder="e.g. 100.00" required>
        </div>

        <div class="input-group">
            <label>From (Source Currency)</label>
            <input type="text" name="currency_from" placeholder="USD" maxlength="10" required>
        </div>

        <div class="input-group">
            <label>To (Target Currency)</label>
            <input type="text" name="currency_to" placeholder="INR" maxlength="10" required>
        </div>

        <button type="submit">Convert Currency</button>
    </form>

    <%-- Logic to display the result or error message --%>
    <% 
        String result = (String) request.getAttribute("result");
        if(result != null) { 
            boolean isError = result.contains("Error");
    %>
        <div class="result-box <%= isError ? "error" : "success" %>">
            <%= result %>
        </div>
    <% } %>
</div>

</body>
</html>
