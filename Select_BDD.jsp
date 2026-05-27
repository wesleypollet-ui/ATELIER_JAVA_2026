<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>Connexion à MariaDB via JSP</title>
    <link rel="stylesheet" href="style-clean.css">
</head>
<body>
<%@ include file="header.jspf" %>
    <h1>Exemple de connexion à MariaDB avec JSP</h1>
    <% 
    // Les identifiants de connexion doivent être fournis via des variables d'environnement
    String url = System.getenv("DB_URL");
    String user = System.getenv("DB_USER");
    String password = System.getenv("DB_PASSWORD");

    if (url == null || user == null || password == null) {
    %>
        <p style="color:orange;">Configuration DB manquante. Définir DB_URL, DB_USER, DB_PASSWORD dans les variables d'environnement du serveur.</p>
    <%
    } else {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            // Charger le pilote (doit être présent dans WEB-INF/lib)
            Class.forName("org.mariadb.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);

            // Exemple de requête SQL
            String sql = "SELECT idFilm, titre, annee FROM Film WHERE annee >= 2000";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            // Afficher les résultats
            while (rs.next()) {
                String colonne1 = rs.getString("idFilm");
                String colonne2 = rs.getString("titre");
                String colonne3 = rs.getString("annee");
                out.println("id : " + colonne1 + ", titre : " + colonne2 + ", année : " + colonne3 + "</br>");
            }
        } catch (Exception e) {
            out.println("<p style='color:red;'>Erreur lors de la connexion à la base de données: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception ignored) {}
            if (pstmt != null) try { pstmt.close(); } catch (Exception ignored) {}
            if (conn != null) try { conn.close(); } catch (Exception ignored) {}
        }
    }
    %>

<h2>Exercice 1 : Les films entre 2000 et 2015</h2>
<p>Extraire les films dont l'année est supérieur à l'année 2000 et inférieur à 2015.</p>

<h2>Exercice 2 : Année de recherche</h2>
<p>Créer un champ de saisie permettant à l'utilisateur de choisir l'année de sa recherche.</p>

<h2>Exercice 3 : Modification du titre du film</h2>
<p>Créer un fichier permettant de modifier le titre d'un film sur la base de son ID (ID choisi par l'utilisateur)</p>

<h2>Exercice 4 : La valeur maximum</h2>
<p>Créer un formulaire pour saisir un nouveau film dans la base de données</p>
<hr>
<h3>Projet Bibliothèque</h3>
<p>Votre projet consiste à concevoir et développer une application de gestion de bibliothèque moderne qui simplifie le processus de prêt et de retour de livres. Les fonctionnalités attendues dans le cadre de ce projet sont les suivantes :
<ul>
<li>L’enregistrement et la suppression de livres.</li>
<li>La recherche de livres disponibles.</li>
<li>L'emprunt possible d'un livre par un utilisateur.</li>
<li>La gestion des utilisateurs.</li>
<li>La gestion des stocks.</li>
</ul>
Votre travail est de créer votre code afin de répondre aux besoins définis ci-dessus. L'application exploitera le language JSP (JAVA) pour interagir avec la base de données MariaDB.
L’application pourra être enrichie avec des fonctionnalités supplémentaires telles que des recommandations de livres, des notifications pour les retours en retard, ou encore des rapports statistiques sur l'utilisation des livres pour améliorer l'expérience utilisateur et la gestion de la bibliothèque.
</p>
<%@ include file="footer.jspf" %>
</body>
</html>
