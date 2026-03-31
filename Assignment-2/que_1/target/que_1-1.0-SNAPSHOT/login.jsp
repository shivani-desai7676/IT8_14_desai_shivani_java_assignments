<%-- 
    Document   : login
    Created on : 22-Jan-2026, 10:50:52 am
    Author     : root
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Fashion Store | Sign In</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --accent-red: #dc3545;
            --dark-bg: #1a1a1a;
        }

        body {
            background-color: #f4f4f4;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            height: 100vh;
            margin: 0;
            overflow: hidden;
        }

        .login-wrapper {
            display: flex;
            height: 100vh;
            width: 100%;
        }

        /* Modern Split Side - Dark Brand Side */
        .brand-side {
            background: linear-gradient(135deg, var(--dark-bg) 0%, #333 100%);
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            width: 40%;
            padding: 40px;
            text-align: center;
        }

        .brand-side h1 {
            font-size: 3rem;
            font-weight: 800;
            letter-spacing: -1px;
            margin-bottom: 10px;
        }

        .brand-side span { color: var(--accent-red); }

        /* Form Side */
        .form-side {
            width: 60%;
            display: flex;
            justify-content: center;
            align-items: center;
            background: white;
            position: relative;
        }

        .login-card {
            width: 100%;
            max-width: 400px;
            padding: 20px;
        }

        .form-control {
            border-radius: 8px;
            padding: 12px 15px;
            border: 1px solid #ddd;
            margin-bottom: 5px;
        }

        .form-control:focus {
            box-shadow: 0 0 0 3px rgba(220, 53, 69, 0.1);
            border-color: var(--accent-red);
        }

        .btn-signin {
            background: var(--dark-bg);
            color: white;
            border: none;
            padding: 12px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-signin:hover {
            background: var(--accent-red);
            color: white;
            transform: translateY(-2px);
        }

        .social-login {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .social-btn {
            flex: 1;
            border: 1px solid #ddd;
            background: white;
            padding: 8px;
            border-radius: 8px;
            font-size: 14px;
            transition: 0.2s;
        }

        .social-btn:hover { background: #f8f9fa; }

        @media (max-width: 768px) {
            .brand-side { display: none; }
            .form-side { width: 100%; }
        }
    </style>
</head>
<body>

<div class="login-wrapper">
    <div class="brand-side">
        <h1>FASHION<span>HUB</span></h1>
        <p class="lead">Elevate your style with our latest collection.</p>
        <div class="mt-4">
            <i class="fas fa-quote-left opacity-50"></i>
            <p class="fst-italic small px-5">"Fashion is the armor to survive the reality of everyday life."</p>
        </div>
    </div>

    <div class="form-side">
        <div class="login-card">
            <div class="mb-4">
                <h3 class="fw-bold m-0">Sign In</h3>
                <p class="text-muted small">Access your account to manage orders</p>
            </div>

            <%
                String error = request.getParameter("err");
                String msg = "";
                if (error != null) {
                    if (error.equals("invalid")) msg = "Invalid Login ID or Password.";
                    else if (error.equals("db")) msg = "Database unreachable.";
                    else if (error.equals("logged_out")) msg = "Successfully logged out!";
            %>
                <div class="alert alert-danger border-0 small py-2 text-center mb-4" style="background: #fff5f5; color: #c53030;">
                    <i class="fas fa-exclamation-circle me-2"></i> <%= msg %>
                </div>
            <% } %>

            <form action="LoginServlet" method="POST">
                <div class="mb-3">
                    <label class="form-label small fw-bold">Login ID</label>
                    <input type="text" name="txt_login" class="form-control" placeholder="Enter your ID" required>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-bold">Password</label>
                    <input type="password" name="txt_pass" class="form-control" placeholder="••••••••" required>
                </div>
                
                <div class="mb-4 d-flex justify-content-between align-items-center">
                    <div class="form-check m-0">
                        <input type="checkbox" name="chk_remember" class="form-check-input" id="rem">
                        <label class="form-check-label small text-muted" for="rem">Remember me</label>
                    </div>
                    <a href="forgot_password.jsp" class="text-decoration-none text-danger small fw-bold">Forgot?</a>
                </div>

                <button type="submit" class="btn btn-signin w-100 mb-3">Login to Account</button>
                
                <div class="text-center">
                    <span class="text-muted small">Don't have an account? </span>
                    <a href="register.jsp" class="text-danger small fw-bold text-decoration-none">Sign Up</a>
                </div>
            </form>

<!--            <div class="mt-5 pt-4 border-top">
                <p class="text-center text-muted small mb-3">Or continue with</p>
                <div class="social-login">
                    <button class="social-btn"><i class="fab fa-google text-danger"></i> Google</button>
                    <button class="social-btn"><i class="fab fa-facebook-f text-primary"></i> Facebook</button>
                </div>
            </div>-->
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>