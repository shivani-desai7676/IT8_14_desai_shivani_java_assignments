<%-- 
    Document   : index
    Created on : 20-Jan-2026, 11:47:22 am
    Author     : root
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Fashion Store | Curated Style</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,700;1,700&family=Plus+Jakarta+Sans:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --accent: #dc3545;
            --soft-bg: #fdfdfd;
            --dark: #121212;
        }

        body { 
            font-family: 'Plus Jakarta Sans', sans-serif; 
            background-color: var(--soft-bg);
            color: var(--dark);
        }

        /* Minimalist Navbar */
        .navbar {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid #eee;
            padding: 20px 0;
        }
        .navbar-brand { font-family: 'Playfair Display', serif; letter-spacing: 1px; }

        /* Aesthetic Hero Section (No heavy images) */
        .hero-section {
            padding: 120px 0;
            background: radial-gradient(circle at 10% 20%, rgba(220, 53, 69, 0.05) 0%, rgba(255, 255, 255, 1) 90%);
            position: relative;
        }

        .hero-title { 
            font-family: 'Playfair Display', serif; 
            font-size: 4.5rem; 
            line-height: 1.1;
            margin-bottom: 25px;
        }

        .hero-title span { font-style: italic; color: var(--accent); }

        /* Modern Category Links */
        .category-link {
            text-decoration: none;
            color: var(--dark);
            display: block;
            border: 1px solid #e0e0e0;
            padding: 40px 20px;
            border-radius: 0;
            transition: all 0.4s ease;
            text-align: center;
            background: white;
        }

        .category-link:hover {
            border-color: var(--dark);
            background: var(--dark);
            color: white;
            transform: translateY(-5px);
        }

        .category-link i { font-size: 2rem; margin-bottom: 15px; display: block; }

        /* Subtle Section Heading */
        .section-tag {
            text-transform: uppercase;
            letter-spacing: 3px;
            font-size: 0.75rem;
            color: var(--accent);
            font-weight: 700;
            margin-bottom: 15px;
            display: block;
        }

        /* Elegant Button */
        .btn-luxury {
            background: var(--dark);
            color: white;
            padding: 15px 40px;
            border-radius: 0;
            font-weight: 600;
            letter-spacing: 1px;
            transition: 0.3s;
            border: 1px solid var(--dark);
        }

        .btn-luxury:hover {
            background: transparent;
            color: var(--dark);
        }

        footer {
            border-top: 1px solid #eee;
            padding: 40px 0;
            font-size: 0.8rem;
            color: white;
             background: radial-gradient(circle at 10% 20%, rgba(220, 53, 69, 0.05) 0%, rgba(255, 255, 255, 1) 90%);
            /*background: black;*/
            /*background: transparent;*/
            letter-spacing: 1px;
            text-transform: uppercase;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-light sticky-top">
        <div class="container">
            <a class="navbar-brand fw-bold fs-3" href="#">FASHION<span class="text-danger">HUB</span></a>
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item"><a class="nav-link px-3" href="index.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link px-3" href="login.jsp">Shop</a></li>
                    <li class="nav-item ms-lg-4"><a class="nav-link text-muted small" href="login.jsp">Sign In</a></li>
                    <li class="nav-item"><a class="btn btn-luxury btn-sm ms-lg-3" href="register.jsp">Join Now</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <header class="hero-section">
        <div class="container text-center">
            <span class="section-tag">New Season 2026</span>
            <h1 class="hero-title">Redefining <span>Modern</span><br>Simplicity.</h1>
            <p class="lead mb-5 text-muted mx-auto" style="max-width: 600px;">
                Explore a curated collection where quality meets timeless design. Get 50% off during our spring launch.
            </p>
            <a href="login.jsp" class="btn btn-luxury">Explore Collection <i class="fas fa-arrow-right ms-2"></i></a>
        </div>
    </header>

    <section class="container my-5 py-5">
        <div class="text-center mb-5">
            <span class="section-tag">Categories</span>
            <h2 class="fw-bold h1">Shop by Department</h2>
        </div>
        <div class="row g-0"> <div class="col-md-4">
                <a href="login.jsp" class="category-link">
                    <i class="fas fa-venus"></i>
                    <h5 class="fw-bold">Women</h5>
                    <span class="small text-muted">Shop Essentials</span>
                </a>
            </div>
            <div class="col-md-4">
                <a href="login.jsp" class="category-link">
                    <i class="fas fa-mars"></i>
                    <h5 class="fw-bold">Men</h5>
                    <span class="small text-muted">Curated Styles</span>
                </a>
            </div>
            <div class="col-md-4">
                <a href="login.jsp" class="category-link">
                    <i class="fas fa-gem"></i>
                    <h5 class="fw-bold">Accessories</h5>
                    <span class="small text-muted">Finishing Touches</span>
                </a>
            </div>
        </div>
    </section>

    <section class="py-5 bg-white border-top border-bottom">
        <div class="container text-center py-4">
            <h5 class="fw-light mb-3 italic">"Style is a way to say who you are without having to speak."</h5>
            <div class="d-flex justify-content-center align-items-center gap-4">
                <span class="small fw-bold border-bottom border-danger">#FASHION2026</span>
                <span class="text-muted small">Extra 10% Off with code: <strong class="text-dark">LUXE10</strong></span>
            </div>
        </div>
    </section>

    <footer class="text-center text-muted">
        <div class="container">
            <div class="mb-3">
                <a href="#" class="text-muted me-3 text-decoration-none"><i class="fab fa-instagram"></i></a>
                <a href="#" class="text-muted me-3 text-decoration-none"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="text-muted text-decoration-none"><i class="fab fa-pinterest"></i></a>
            </div>
            <p class="m-0">&copy; 2026 Fashion Hub Boutique. All Rights Reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>