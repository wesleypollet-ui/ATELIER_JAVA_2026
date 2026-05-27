<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.time.*,javax.servlet.*" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tâches — Atelier Java</title>
    <link rel="stylesheet" href="style-clean.css">
</head>
<body>
<%@ include file="header.jspf" %>

<div class="container">
    <section class="hero">
        <h1>Tâches</h1>
        <p>Ajoutez, supprimez et marquez une tâche comme terminée.</p>
    </section>

    <section>
        <h2>Nouvelle tâche</h2>
        <form method="post">
            <input type="hidden" name="action" value="add">
            <label>Titre<br><input type="text" name="title" required style="width:100%;padding:0.5rem;border-radius:6px"></label><br><br>
            <label>Description<br><textarea name="description" rows="3" style="width:100%;padding:0.5rem;border-radius:6px"></textarea></label><br><br>
            <label>Date début<br><input type="date" name="startDate"></label>
            &nbsp;
            <label>Date échéance<br><input type="date" name="dueDate"></label>
            <br><br>
            <input type="submit" value="Ajouter" class="btn-primary" style="padding:0.5rem 1rem;border-radius:6px">
        </form>
    </section>

    <hr>

    <section>
        <h2>Liste des tâches</h2>

        <%-- Server-side classes and helpers --%>
        <%! 
            private static final long serialVersionUID = 1L;
            public static class Task implements Serializable {
                private static final long serialVersionUID = 1L;
                public String id;
                public String title;
                public String description;
                public String startDate; // ISO yyyy-MM-dd or null
                public String dueDate;
                public boolean completed;

                public Task(String title, String description, String startDate, String dueDate) {
                    this.id = java.util.UUID.randomUUID().toString();
                    this.title = title;
                    this.description = description;
                    this.startDate = startDate;
                    this.dueDate = dueDate;
                    this.completed = false;
                }
            }

            private synchronized java.util.List<Task> loadTasks(ServletContext application) throws Exception {
                String path = application.getRealPath("/WEB-INF/tasks.dat");
                File f = new File(path);
                if (!f.exists()) return new ArrayList<Task>();
                ObjectInputStream ois = null;
                try {
                    ois = new ObjectInputStream(new FileInputStream(f));
                    Object o = ois.readObject();
                    return (ArrayList<Task>) o;
                } finally {
                    if (ois != null) try { ois.close(); } catch(Exception ignored){}
                }
            }

            private synchronized void saveTasks(ServletContext application, java.util.List<Task> tasks) throws Exception {
                String path = application.getRealPath("/WEB-INF/tasks.dat");
                File f = new File(path);
                File dir = f.getParentFile();
                if (!dir.exists()) dir.mkdirs();
                File tmp = new File(path + ".tmp");
                ObjectOutputStream oos = null;
                try {
                    oos = new ObjectOutputStream(new FileOutputStream(tmp));
                    oos.writeObject(new ArrayList<Task>(tasks));
                    oos.flush();
                    if (f.exists()) f.delete();
                    tmp.renameTo(f);
                } finally {
                    if (oos != null) try { oos.close(); } catch(Exception ignored){}
                }
            }
        %>

        <%
            // Handle actions: add, delete, toggle
            String action = request.getParameter("action");
            String taskId = request.getParameter("id");
            java.util.List<Task> tasks = null;
            try {
                tasks = loadTasks(application);
                if (action != null) {
                    if (action.equals("add")) {
                        String title = request.getParameter("title");
                        String description = request.getParameter("description");
                        String startDate = request.getParameter("startDate");
                        String dueDate = request.getParameter("dueDate");
                        if (title != null && !title.trim().isEmpty()) {
                            Task t = new Task(title.trim(), description==null?"":description.trim(), (startDate!=null && !startDate.isEmpty())?startDate:null, (dueDate!=null && !dueDate.isEmpty())?dueDate:null);
                            tasks.add(0, t);
                            saveTasks(application, tasks);
                        }
                        response.sendRedirect("taches.jsp");
                        return;
                    } else if (action.equals("delete") && taskId != null) {
                        Iterator<Task> it = tasks.iterator();
                        while (it.hasNext()) {
                            Task t = it.next();
                            if (t.id.equals(taskId)) { it.remove(); break; }
                        }
                        saveTasks(application, tasks);
                        response.sendRedirect("taches.jsp");
                        return;
                    } else if (action.equals("toggle") && taskId != null) {
                        for (Task t : tasks) {
                            if (t.id.equals(taskId)) { t.completed = !t.completed; break; }
                        }
                        saveTasks(application, tasks);
                        response.sendRedirect("taches.jsp");
                        return;
                    }
                }
            } catch (Exception e) {
                out.println("<p style='color:red;'>Erreur tâches: " + e.getMessage() + "</p>");
                tasks = (tasks==null)?new ArrayList<Task>():tasks;
            }

            String filter = request.getParameter("filter");
            if (filter == null) filter = "all";
            if (tasks.isEmpty()) {
                out.println("<p>Aucune tâche pour le moment.</p>");
            } else {
        %>
            <form method="get" style="margin:0 0 1rem 0">
                <label>Filtrer :
                    <select name="filter" onchange="this.form.submit()">
                        <option value="all" <%= "all".equals(filter) ? "selected" : "" %>>Toutes</option>
                        <option value="upcoming" <%= "upcoming".equals(filter) ? "selected" : "" %>>À venir</option>
                        <option value="ongoing" <%= "ongoing".equals(filter) ? "selected" : "" %>>En cours</option>
                        <option value="overdue" <%= "overdue".equals(filter) ? "selected" : "" %>>En retard</option>
                        <option value="completed" <%= "completed".equals(filter) ? "selected" : "" %>>Terminé</option>
                    </select>
                </label>
            </form>
                <div style="display:grid;gap:1rem;margin-top:1rem">
                <%
                    java.time.LocalDate today = java.time.LocalDate.now();
                    for (Task t : tasks) {
                        // compute dates and status
                        java.time.LocalDate start = null; java.time.LocalDate due = null;
                        try { if (t.startDate != null) start = java.time.LocalDate.parse(t.startDate); } catch(Exception ignored) {}
                        try { if (t.dueDate != null) due = java.time.LocalDate.parse(t.dueDate); } catch(Exception ignored) {}

                        String status = "En cours";
                        if (t.completed) {
                            status = "Terminé";
                        } else if (start != null && start.isAfter(today)) {
                            long days = java.time.temporal.ChronoUnit.DAYS.between(today, start);
                            status = "À venir J-" + days;
                        } else if (due != null && due.isBefore(today)) {
                            long days = java.time.temporal.ChronoUnit.DAYS.between(due, today);
                            status = "En retard J+" + days;
                        } else {
                            status = "En cours";
                        }

                        boolean show = true;
                        if ("upcoming".equals(filter)) {
                            show = (!t.completed && start != null && start.isAfter(today));
                        } else if ("ongoing".equals(filter)) {
                            boolean started = (start == null) || !start.isAfter(today);
                            boolean notOverdue = (due == null) || !due.isBefore(today);
                            show = (!t.completed && started && notOverdue);
                        } else if ("overdue".equals(filter)) {
                            show = (!t.completed && due != null && due.isBefore(today));
                        } else if ("completed".equals(filter)) {
                            show = t.completed;
                        }

                        if (!show) continue;
                %>
                    <div class="card" style="display:flex;justify-content:space-between;align-items:flex-start;">
                        <div style="max-width:80%">
                            <h3 style="margin:0;">
                                <%= t.title %>
                                <small style="margin-left:0.5rem;color:#6b7280;font-weight:600;"><%= status %></small>
                            </h3>
                            <p style="color:#6b7280;margin:0.25rem 0;"><%= t.description %></p>
                            <p style="color:#6b7280;margin:0.25rem 0;font-size:0.9rem">
                                <% if (t.startDate != null) { out.print("Début: " + t.startDate + " "); } %>
                                <% if (t.dueDate != null) { out.print("• Échéance: " + t.dueDate); } %>
                            </p>
                        </div>
                        <div style="display:flex;flex-direction:column;gap:0.5rem;align-items:flex-end">
                            <form method="post" style="margin:0">
                                <input type="hidden" name="action" value="toggle">
                                <input type="hidden" name="id" value="<%= t.id %>">
                                <button type="submit" class="btn-primary" style="padding:0.4rem 0.6rem;border-radius:6px"> <%=(t.completed?"Marquer non terminé":"Terminer")%> </button>
                            </form>
                            <form method="post" style="margin:0">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="<%= t.id %>">
                                <button type="submit" style="background:#eee;border:none;padding:0.4rem 0.6rem;border-radius:6px;">Supprimer</button>
                            </form>
                        </div>
                    </div>
                <%
                    }
                %>
                </div>
        <%
            }
        %>
    </section>

    <section style="padding:2rem 0;border-bottom:none;">
        <a href="index.html" class="nav-link">← Retour à l'accueil</a>
    </section>

</div>

<%@ include file="footer.jspf" %>
</body>
</html>
