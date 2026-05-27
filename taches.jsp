<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.time.*,javax.servlet.*" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tâches — Atelier Java</title>
    <link rel="stylesheet" href="style-clean.css">
    <style>
        .tasks-layout{display:grid;grid-template-columns:420px 1fr;gap:1.5rem;align-items:start}
        .left-col{display:flex;flex-direction:column;gap:1rem}
        .calendar {display:grid;grid-template-columns:repeat(7,1fr);gap:6px}
        .calendar .day{padding:6px;border-radius:6px;background:var(--card);border:1px solid rgba(15,23,36,0.04);min-height:100px;position:relative}
        .calendar .muted{color:var(--muted);opacity:0.7}
        .date-dot{width:8px;height:8px;border-radius:50%;background:var(--accent);display:inline-block;margin-left:6px}
        .calendar-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:8px}
        .tasks-for-day{margin-top:8px}
        .task-bar{height:14px;border-radius:6px;margin-top:6px;color:#fff;font-size:11px;padding:2px 6px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis}
        .task-color-dot{display:inline-block;width:12px;height:12px;border-radius:50%;vertical-align:middle;margin-right:6px}
        @media(max-width:900px){.tasks-layout{grid-template-columns:1fr;}.calendar{grid-template-columns:repeat(7,1fr);}}
    </style>
</head>
<body>
<%@ include file="header.jspf" %>
<div class="container">
    <section class="hero">
        <h1>Tâches</h1>
        <p>Ajout, modification, calendrier et filtrage.</p>
    </section>

    <%
    // Server-side task model + persistence (with color)
    %>

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
            public String color;

            public Task(String title, String description, String startDate, String dueDate, String color) {
                this.id = java.util.UUID.randomUUID().toString();
                this.title = title;
                this.description = description;
                this.startDate = startDate;
                this.dueDate = dueDate;
                this.completed = false;
                this.color = (color==null || color.isEmpty())?"#2563EB":color;
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
        // Load tasks and handle POST actions (add, delete, toggle, save)
        String method = request.getMethod();
        String action = request.getParameter("action");
        String taskId = request.getParameter("id");
        java.util.List<Task> tasks = null;
        try {
            tasks = loadTasks(application);
            if ("POST".equalsIgnoreCase(method) && action != null) {
                if (action.equals("add")) {
                    String title = request.getParameter("title");
                    String description = request.getParameter("description");
                    String startDate = request.getParameter("startDate");
                    String dueDate = request.getParameter("dueDate");
                    String color = request.getParameter("color");
                    if (title != null && !title.trim().isEmpty()) {
                        Task t = new Task(title.trim(), description==null?"":description.trim(), (startDate!=null && !startDate.isEmpty())?startDate:null, (dueDate!=null && !dueDate.isEmpty())?dueDate:null, color);
                        tasks.add(0, t);
                        saveTasks(application, tasks);
                    }
                    response.sendRedirect("taches.jsp"); return;
                } else if (action.equals("delete") && taskId != null) {
                    Iterator<Task> it = tasks.iterator(); while (it.hasNext()) { Task t = it.next(); if (t.id.equals(taskId)) { it.remove(); break; } }
                    saveTasks(application, tasks); response.sendRedirect("taches.jsp"); return;
                } else if (action.equals("toggle") && taskId != null) {
                    for (Task t : tasks) { if (t.id.equals(taskId)) { t.completed = !t.completed; break; } }
                    saveTasks(application, tasks); response.sendRedirect("taches.jsp"); return;
                } else if (action.equals("save") && taskId != null) {
                    for (Task t : tasks) {
                        if (t.id.equals(taskId)) {
                            String title = request.getParameter("title");
                            String description = request.getParameter("description");
                            String startDate = request.getParameter("startDate");
                            String dueDate = request.getParameter("dueDate");
                            String color = request.getParameter("color");
                            if (title != null) t.title = title.trim();
                            t.description = (description==null)?"":description.trim();
                            t.startDate = (startDate!=null && !startDate.isEmpty())?startDate:null;
                            t.dueDate = (dueDate!=null && !dueDate.isEmpty())?dueDate:null;
                            t.color = (color==null || color.isEmpty())?t.color:color;
                            break;
                        }
                    }
                    saveTasks(application, tasks); response.sendRedirect("taches.jsp"); return;
                }
            }
        } catch (Exception e) {
            out.println("<p style='color:red;'>Erreur tâches: " + e.getMessage() + "</p>"); tasks = (tasks==null)?new ArrayList<Task>():tasks;
        }

        // If editing requested via GET ?edit_id=...
        String editId = request.getParameter("edit_id");
        Task editingTask = null;
        if (editId != null && !editId.isEmpty()) {
            for (Task t : tasks) { if (t.id.equals(editId)) { editingTask = t; break; } }
        }
    %>

    <div class="tasks-layout">
        <div class="left-col">
            <section>
                <% if (editingTask != null) { %>
                    <h2>Modifier la tâche</h2>
                    <form method="post">
                        <input type="hidden" name="action" value="save">
                        <input type="hidden" name="id" value="<%= editingTask.id %>">
                        <label>Titre<br><input type="text" name="title" required value="<%= editingTask.title.replace("\"","\\\"") %>" style="width:100%;padding:0.5rem;border-radius:6px"></label><br><br>
                        <label>Description<br><textarea name="description" rows="3" style="width:100%;padding:0.5rem;border-radius:6px"><%= editingTask.description.replace("<","&lt;").replace(">","&gt;") %></textarea></label><br><br>
                        <label>Date début<br><input type="date" name="startDate" value="<%= editingTask.startDate!=null?editingTask.startDate:"" %>"></label>
                        &nbsp;
                        <label>Date échéance<br><input type="date" name="dueDate" value="<%= editingTask.dueDate!=null?editingTask.dueDate:"" %>"></label>
                        <br><br>
                        <label>Couleur<br><input type="color" name="color" value="<%= editingTask.color!=null?editingTask.color:"#2563EB" %>"></label>
                        <br><br>
                        <input type="submit" value="Enregistrer" class="btn-primary">
                        &nbsp;<a href="taches.jsp">Annuler</a>
                    </form>
                <% } else { %>
                    <h2>Nouvelle tâche</h2>
                    <form method="post">
                        <input type="hidden" name="action" value="add">
                        <label>Titre<br><input type="text" name="title" required style="width:100%;padding:0.5rem;border-radius:6px"></label><br><br>
                        <label>Description<br><textarea name="description" rows="3" style="width:100%;padding:0.5rem;border-radius:6px"></textarea></label><br><br>
                        <label>Date début<br><input type="date" name="startDate"></label>
                        &nbsp;
                        <label>Date échéance<br><input type="date" name="dueDate"></label>
                        <br><br>
                        <label>Couleur<br><input type="color" name="color" value="#2563EB"></label>
                        <br><br>
                        <input type="submit" value="Ajouter" class="btn-primary">
                    </form>
                <% } %>
            </section>

            <section>
                <h2>Liste des tâches</h2>
                <form method="get" style="margin:0 0 1rem 0">
                    <label>Filtrer :
                        <select name="filter" onchange="this.form.submit()">
                            <option value="all" <%= "all".equals(request.getParameter("filter")) || request.getParameter("filter")==null ? "selected" : "" %>>Toutes</option>
                            <option value="upcoming" <%= "upcoming".equals(request.getParameter("filter")) ? "selected" : "" %>>À venir</option>
                            <option value="ongoing" <%= "ongoing".equals(request.getParameter("filter")) ? "selected" : "" %>>En cours</option>
                            <option value="overdue" <%= "overdue".equals(request.getParameter("filter")) ? "selected" : "" %>>En retard</option>
                            <option value="completed" <%= "completed".equals(request.getParameter("filter")) ? "selected" : "" %>>Terminé</option>
                        </select>
                    </label>
                </form>

                <%
                    String filter = request.getParameter("filter"); if (filter == null) filter = "all";
                    if (tasks.isEmpty()) { out.println("<p>Aucune tâche pour le moment.</p>"); }
                    else {
                        java.time.LocalDate today = java.time.LocalDate.now();
                %>
                <div style="display:grid;gap:1rem;margin-top:1rem">
                <%
                    for (Task t : tasks) {
                        java.time.LocalDate start = null; java.time.LocalDate due = null;
                        try { if (t.startDate != null) start = java.time.LocalDate.parse(t.startDate); } catch(Exception ignored) {}
                        try { if (t.dueDate != null) due = java.time.LocalDate.parse(t.dueDate); } catch(Exception ignored) {}

                        String status = "En cours";
                        if (t.completed) { status = "Terminé"; }
                        else if (start != null && start.isAfter(today)) { long days = java.time.temporal.ChronoUnit.DAYS.between(today, start); status = "À venir J-" + days; }
                        else if (due != null && due.isBefore(today)) { long days = java.time.temporal.ChronoUnit.DAYS.between(due, today); status = "En retard J+" + days; }
                        else { status = "En cours"; }

                        boolean show = true;
                        if ("upcoming".equals(filter)) { show = (!t.completed && start != null && start.isAfter(today)); }
                        else if ("ongoing".equals(filter)) { boolean started = (start == null) || !start.isAfter(today); boolean notOverdue = (due == null) || !due.isBefore(today); show = (!t.completed && started && notOverdue); }
                        else if ("overdue".equals(filter)) { show = (!t.completed && due != null && due.isBefore(today)); }
                        else if ("completed".equals(filter)) { show = t.completed; }
                        if (!show) continue;
                %>
                    <div class="card" style="display:flex;justify-content:space-between;align-items:flex-start;">
                        <div style="max-width:70%">
                            <h3 style="margin:0;">
                                <span class="task-color-dot" style="background:<%= t.color %>"></span>
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
                            <a href="taches.jsp?edit_id=<%= t.id %>" class="btn-secondary" style="padding:0.4rem 0.6rem;border-radius:6px;text-decoration:none;display:inline-block">Modifier</a>
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
        </div>

        <div>
            <section>
                <h2>Calendrier</h2>
                <div id="calendarControls" style="display:flex;gap:8px;align-items:center;margin-bottom:8px">
                    <button id="prevMonth" class="btn-secondary">«</button>
                    <div id="monthLabel" style="font-weight:600"></div>
                    <button id="nextMonth" class="btn-secondary">»</button>
                </div>
                <div class="calendar" id="calendar"></div>
                <div class="tasks-for-day" id="tasksForDay"></div>
            </section>
        </div>
    </div>

    <section style="padding:2rem 0;border-bottom:none;">
        <a href="index.html" class="nav-link">← Retour à l'accueil</a>
    </section>

</div>

<%@ include file="footer.jspf" %>

<script>
// Build tasksData JS from server-side tasks for calendar
var tasksData = [];
<%
    // Emit tasks as JS array safely
    for (Task t : tasks) {
        String safeTitle = (t.title==null) ? "" : t.title.replace("\\","\\\\").replace("\"","\\\"").replace("\n","\\n").replace("\r","\\r");
        String safeDesc = (t.description==null) ? "" : t.description.replace("\\","\\\\").replace("\"","\\\"").replace("\n","\\n").replace("\r","\\r");
        out.print("tasksData.push({id:\""+t.id+"\",title:\""+safeTitle+"\",description:\""+safeDesc+"\",startDate:\"");
        out.print(t.startDate==null?"":t.startDate);
        out.print("\",dueDate:\"");
        out.print(t.dueDate==null?"":t.dueDate);
        out.print("\",completed:");
        out.print(t.completed);
        out.print("});\n");
    }
%>

// Calendar rendering (with timeline bands)
(function(){
    var cur = new Date();
    var year = cur.getFullYear(), month = cur.getMonth();
    var calendarEl = document.getElementById('calendar');
    var monthLabel = document.getElementById('monthLabel');
    var tasksForDay = document.getElementById('tasksForDay');

    function render(){
        calendarEl.innerHTML='';
        var first = new Date(year, month, 1);
        var startDay = (first.getDay()+6)%7; // make Monday=0
        var daysInMonth = new Date(year, month+1, 0).getDate();
        monthLabel.textContent = first.toLocaleString(undefined,{month:'long', year:'numeric'});

        // week day headers
        var days = ['Lun','Mar','Mer','Jeu','Ven','Sam','Dim'];
        for(var i=0;i<7;i++){ var h = document.createElement('div'); h.className='muted'; h.style.fontWeight='600'; h.textContent=days[i]; calendarEl.appendChild(h); }

        for(var i=0;i<startDay;i++){ var e=document.createElement('div'); e.className='day muted'; e.textContent=''; calendarEl.appendChild(e); }
        for(var d=1; d<=daysInMonth; d++){
            var e = document.createElement('div'); e.className='day';
            e.dataset.date = year+'-'+String(month+1).padStart(2,'0')+'-'+String(d).padStart(2,'0');
            var title = document.createElement('div'); title.style.fontWeight='600'; title.textContent = d; e.appendChild(title);
            calendarEl.appendChild(e);
        }

        // render task bars across days
        tasksData.forEach(function(t){
            if(!t.dueDate && !t.startDate) return;
            var s = t.startDate?new Date(t.startDate):new Date(year,month,1);
            var eDate = t.dueDate?new Date(t.dueDate):s;
            // clamp to current month
            var from = new Date(Math.max(new Date(year,month,1).getTime(), s.getTime()));
            var to = new Date(Math.min(new Date(year,month+1,0).getTime(), eDate.getTime()));
            if (from>to) return;
            var startDayOfMonth = from.getDate();
            var endDayOfMonth = to.getDate();
            for(var day=startDayOfMonth; day<=endDayOfMonth; day++){
                var dateStr = year+'-'+String(month+1).padStart(2,'0')+'-'+String(day).padStart(2,'0');
                var cell = calendarEl.querySelector('[data-date="'+dateStr+'"]');
                if(!cell) continue;
                var bar = document.createElement('div');
                bar.className='task-bar';
                bar.style.background = (t.color? t.color : '#2563EB');
                bar.textContent = t.title;
                bar.title = t.title + ' - ' + t.description;
                cell.appendChild(bar);
            }
        });

        // add click handlers
        var cells = calendarEl.querySelectorAll('.day');
        cells.forEach(function(c){ c.addEventListener('click', function(){ showTasksFor(this.dataset.date); }); });
    }

    function showTasksFor(date){
        var filtered = tasksData.filter(function(t){
            if (t.dueDate && t.startDate) return (t.startDate<=date && t.dueDate>=date);
            if (t.dueDate) return t.dueDate===date;
            if (t.startDate) return t.startDate===date;
            return false;
        });
        if(filtered.length===0){ tasksForDay.innerHTML = '<p>Aucune tâche pour '+date+'</p>'; return; }
        var html = '<h3>Tâches pour ' + date + '</h3><ul>';
        filtered.forEach(function(t){ html += '<li><span style="display:inline-block;width:12px;height:12px;background:'+ (t.color? t.color:'#2563EB') +';border-radius:50%;margin-right:8px;vertical-align:middle"></span><strong>'+escapeHtml(t.title)+'</strong> - '+escapeHtml(t.description)+' '+(t.completed?'<em>(Terminé)</em>':'')+'</li>'; });
        html += '</ul>';
        tasksForDay.innerHTML = html;
    }

    function escapeHtml(s){ return String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/\"/g,'&quot;'); }

    document.getElementById('prevMonth').addEventListener('click', function(){ month--; if(month<0){ month=11; year--; } render(); });
    document.getElementById('nextMonth').addEventListener('click', function(){ month++; if(month>11){ month=0; year++; } render(); });

    // populate tasksData from server
    // same server emission as before but include color and startDate
})();

// emit tasksData from server
<%
    for (Task t : tasks) {
        String safeTitle = (t.title==null) ? "" : t.title.replace("\\","\\\\").replace("\"","\\\"").replace("\n","\\n").replace("\r","\\r");
        String safeDesc = (t.description==null) ? "" : t.description.replace("\\","\\\\").replace("\"","\\\"").replace("\n","\\n").replace("\r","\\r");
        String color = (t.color==null)?"#2563EB":t.color;
        out.print("tasksData.push({id:\""+t.id+"\",title:\""+safeTitle+"\",description:\""+safeDesc+"\",startDate:\"");
        out.print(t.startDate==null?"":t.startDate);
        out.print("\",dueDate:\"");
        out.print(t.dueDate==null?"":t.dueDate);
        out.print("\",completed:");
        out.print(t.completed);
        out.print(",color:\""+color+"\"});\n");
    }
%>

<script>
// re-render with tasksData now populated
(function(){
    var cur = new Date();
    var year = cur.getFullYear(), month = cur.getMonth();
    var calendarEl = document.getElementById('calendar');
    var monthLabel = document.getElementById('monthLabel');
    var tasksForDay = document.getElementById('tasksForDay');

    function render(){
        calendarEl.innerHTML='';
        var first = new Date(year, month, 1);
        var startDay = (first.getDay()+6)%7; // make Monday=0
        var daysInMonth = new Date(year, month+1, 0).getDate();
        monthLabel.textContent = first.toLocaleString(undefined,{month:'long', year:'numeric'});

        var days = ['Lun','Mar','Mer','Jeu','Ven','Sam','Dim'];
        for(var i=0;i<7;i++){ var h = document.createElement('div'); h.className='muted'; h.style.fontWeight='600'; h.textContent=days[i]; calendarEl.appendChild(h); }
        for(var i=0;i<startDay;i++){ var e=document.createElement('div'); e.className='day muted'; e.textContent=''; calendarEl.appendChild(e); }
        for(var d=1; d<=daysInMonth; d++){ var e=document.createElement('div'); e.className='day'; e.dataset.date = year+'-'+String(month+1).padStart(2,'0')+'-'+String(d).padStart(2,'0'); var title = document.createElement('div'); title.style.fontWeight='600'; title.textContent = d; e.appendChild(title); calendarEl.appendChild(e); }

        // render task bars
        tasksData.forEach(function(t){ if(!t.startDate && !t.dueDate) return; var s = t.startDate?new Date(t.startDate):new Date(year,month,1); var eDate = t.dueDate?new Date(t.dueDate):s; var from = new Date(Math.max(new Date(year,month,1).getTime(), s.getTime())); var to = new Date(Math.min(new Date(year,month+1,0).getTime(), eDate.getTime())); if (from>to) return; var startDayOfMonth = from.getDate(); var endDayOfMonth = to.getDate(); for(var day=startDayOfMonth; day<=endDayOfMonth; day++){ var dateStr = year+'-'+String(month+1).padStart(2,'0')+'-'+String(day).padStart(2,'0'); var cell = calendarEl.querySelector('[data-date="'+dateStr+'"]'); if(!cell) continue; var bar = document.createElement('div'); bar.className='task-bar'; bar.style.background = (t.color? t.color : '#2563EB'); bar.textContent = t.title; bar.title = t.title + ' - ' + t.description; cell.appendChild(bar); } });

        var cells = calendarEl.querySelectorAll('.day'); cells.forEach(function(c){ c.addEventListener('click', function(){ showTasksFor(this.dataset.date); }); });
    }

    function showTasksFor(date){ var filtered = tasksData.filter(function(t){ if (t.dueDate && t.startDate) return (t.startDate<=date && t.dueDate>=date); if (t.dueDate) return t.dueDate===date; if (t.startDate) return t.startDate===date; return false; }); if(filtered.length===0){ tasksForDay.innerHTML = '<p>Aucune tâche pour '+date+'</p>'; return; } var html = '<h3>Tâches pour ' + date + '</h3><ul>'; filtered.forEach(function(t){ html += '<li><span style="display:inline-block;width:12px;height:12px;background:'+ (t.color? t.color:'#2563EB') +';border-radius:50%;margin-right:8px;vertical-align:middle"></span><strong>'+escapeHtml(t.title)+'</strong> - '+escapeHtml(t.description)+' '+(t.completed?'<em>(Terminé)</em>':'')+'</li>'; }); html += '</ul>'; tasksForDay.innerHTML = html; }

    function escapeHtml(s){ return String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/\"/g,'&quot;'); }

    document.getElementById('prevMonth').addEventListener('click', function(){ month--; if(month<0){ month=11; year--; } render(); });
    document.getElementById('nextMonth').addEventListener('click', function(){ month++; if(month>11){ month=0; year++; } render(); });

    render();
})();
</script>
</body>
</html>
