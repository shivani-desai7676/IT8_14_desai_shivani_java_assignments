<%-- 
    Document   : register
    Created on : 20-Jan-2026, 11:34:38 am
    Author     : root
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fashion Store | Create Account</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --accent-red: #ff4757;
            --dark-bg: #1a1a1a;
        }

        body {
            background-color: #f4f4f4;
            font-family: 'Poppins', sans-serif;
            margin: 0;
            min-height: 100vh;
        }

        .reg-wrapper {
            display: flex;
            min-height: 100vh;
            width: 100%;
        }

        /* Dark Side Panel */
        .brand-panel {
            background: linear-gradient(135deg, var(--dark-bg) 0%, #333 100%);
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            width: 35%;
            padding: 40px;
            text-align: center;
            position: fixed;
            height: 100vh;
        }

        .brand-panel h1 {
            font-size: 2.5rem;
            font-weight: 800;
            letter-spacing: -1px;
        }

        .brand-panel span { color: var(--accent-red); }

        /* Form Side Panel */
        .form-panel {
            width: 65%;
            margin-left: 35%;
            background: white;
            padding: 60px;
            display: flex;
            justify-content: center;
        }

        .reg-container {
            width: 100%;
            max-width: 700px;
        }

        .form-label {
            font-weight: 600;
            font-size: 0.85rem;
            color: #555;
            margin-bottom: 5px;
        }

        .form-control {
            border-radius: 8px;
            padding: 10px 15px;
            border: 1px solid #ddd;
            font-size: 0.9rem;
        }

        .form-control:focus {
            box-shadow: 0 0 0 3px rgba(255, 71, 87, 0.1);
            border-color: var(--accent-red);
        }

        .btn-register {
            background: var(--dark-bg);
            color: white;
            border: none;
            padding: 14px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            margin-top: 20px;
        }

        .btn-register:hover {
            background: var(--accent-red);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 71, 87, 0.3);
        }

        .captcha-box {
            background: #f8f9fa;
            border: 1px dashed #ccc;
            padding: 15px;
            border-radius: 10px;
        }

        .captcha-img {
            border-radius: 5px;
            height: 45px;
            background: white;
            padding: 2px;
        }

        @media (max-width: 992px) {
            .brand-panel { display: none; }
            .form-panel { width: 100%; margin-left: 0; padding: 30px; }
        }
    </style>
</head>
<body>

<div class="reg-wrapper">
    <div class="brand-panel">
        <h1>FASHION<span>HUB</span></h1>
        <p class="lead opacity-75">Your journey to effortless style starts here.</p>
        <div class="mt-5 text-start w-75 border-start ps-3 border-danger border-3">
            <h5 class="fw-bold">Exclusive Benefits:</h5>
            <ul class="list-unstyled small">
                <li class="mb-2"><i class="fas fa-check-circle me-2 text-danger"></i> Personalized style picks</li>
                <li class="mb-2"><i class="fas fa-check-circle me-2 text-danger"></i> Faster checkout process</li>
                <li class="mb-2"><i class="fas fa-check-circle me-2 text-danger"></i> Early access to sales</li>
            </ul>
        </div>
    </div>

    <div class="form-panel">
        <div class="reg-container">
            <div class="mb-5">
                <h2 class="fw-bold">Create Account</h2>
                <p class="text-muted">Fill in the details to join our fashion community.</p>
            </div>

            <%-- Alert Messages --%>
            <% if(request.getParameter("reg") != null && request.getParameter("reg").equals("fail")) { %>
                <div class="alert alert-danger border-0 small py-2"><i class="fas fa-times-circle me-2"></i> Registration failed.</div>
            <% } %>
            <% if(request.getParameter("msg") != null && request.getParameter("msg").equals("invalid_captcha")) { %>
                <div class="alert alert-warning border-0 small py-2"><i class="fas fa-shield-alt me-2"></i> Invalid Captcha code.</div>
            <% } %>

            <form action="RegisterServlet" method="POST">
                <div class="row g-4">
                    <div class="col-md-6">
                        <h6 class="fw-bold text-danger mb-3 small uppercase text-decoration-underline">Account Details</h6>
                        <div class="mb-3">
                            <label class="form-label">Full Name</label>
                            <input type="text" name="txt_name" class="form-control" placeholder="Enter full name" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Username (Login ID)</label>
                            <input type="text" name="txt_login" class="form-control" placeholder="Choose username" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email Address</label>
                            <input type="email" name="txt_email" class="form-control" placeholder="name@email.com" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password" name="txt_pass" class="form-control" placeholder="Create password" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Phone</label>
                            <input type="text" name="txt_phone" class="form-control" placeholder="+123456789">
                        </div>
                    </div>

                    <div class="col-md-6">
                        <h6 class="fw-bold text-danger mb-3 small uppercase text-decoration-underline">Shipping Info</h6>
                        <div class="mb-3">
                            <label class="form-label">Street Address</label>
                            <textarea name="txt_address" class="form-control" rows="1" placeholder="Address line 1"></textarea>
                        </div>
                        <div class="row">
                            <div class="col-6 mb-3">
                                <label class="form-label">City</label>
                                <input type="text" name="txt_city" class="form-control">
                            </div>
                            <div class="col-6 mb-3">
                                <label class="form-label">State</label>
                                <input type="text" name="txt_state" class="form-control">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6 mb-3">
                                <label class="form-label">Country</label>
                                <input type="text" name="txt_country" class="form-control">
                            </div>
                            <div class="col-6 mb-3">
                                <label class="form-label">Pin Code</label>
                                <input type="text" name="txt_pin" class="form-control">
                            </div>
                        </div>

                        <div class="captcha-box mt-3">
                            <label class="form-label d-block small">Human Verification</label>
                            <div class="d-flex align-items-center gap-3 mb-3">
                                <img src="CaptchaServlet" alt="captcha" class="captcha-img border">
                                <button type="button" class="btn btn-sm btn-link text-danger p-0 shadow-none" onclick="location.reload()"><i class="fas fa-sync"></i></button>
                            </div>
                            <input type="text" name="txt_captcha" class="form-control form-control-sm" placeholder="Type the code above" required>
                        </div>
                    </div>
                </div>

                <div class="mt-5 border-top pt-4">
                    <button type="submit" class="btn btn-register w-100">Create My Account</button>
<!--                    <p class="text-center mt-3 small text-muted">
                        By registering, you agree to our <a href="#" class="text-dark fw-bold">Terms of Service</a>.
                    </p>-->
                    <div class="text-center mt-2">
                        <span class="text-muted">Already a member?</span> 
                        <a href="login.jsp" class="text-danger fw-bold text-decoration-none">Login Here</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>