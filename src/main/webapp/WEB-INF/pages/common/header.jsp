<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String role      = (session != null && session.getAttribute("role") != null) ? (String) session.getAttribute("role") : "";
    String userName  = (session != null && session.getAttribute("userName") != null) ? (String) session.getAttribute("userName") : "";
    String activePage = (request.getAttribute("activePage") != null) ? (String) request.getAttribute("activePage") : "";
    String pageTitle  = (request.getAttribute("pageTitle") != null) ? (String) request.getAttribute("pageTitle") : "SkillForge";
    boolean hasPhoto = (session != null && session.getAttribute("hasPhoto") != null) ? (boolean) session.getAttribute("hasPhoto") : false;
    int userIdS      = (session != null && session.getAttribute("userId") != null) ? (int) session.getAttribute("userId") : 0;
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" content="SkillForge - Online Course Enrollment and Progress Tracking System" />
    <title><%= pageTitle %> - SkillForge</title>
    <!-- Tailwind CSS - self-hosted local copy for offline use and fast load -->
    <script src="<%= ctx %>/js/tailwind.js"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: { sans: ['Inter', 'system-ui', '-apple-system', 'sans-serif'] },
                    colors: {
                        brand: { DEFAULT: '#58cc02', light: '#89e219', dark: '#46a302' },
                        sidebar: { bg: '#ffffff', hover: '#f3f4f6', text: '#64748b', active: '#58cc02' },
                        surface: '#ffffff',
                        background: '#ffffff'
                    }
                }
            }
        }
    </script>
    <!-- System font stack used in style.css; no external Google Fonts dependency -->
    <link rel="stylesheet" href="<%= ctx %>/css/style.css?v=2.4" />

</head>
<body class="font-sans bg-slate-50 text-slate-800 antialiased selection:bg-brand/20 selection:text-brand-dark overflow-x-hidden">
<div class="layout flex h-screen overflow-hidden">

    <!-- Mobile drawer backdrop -->
    <div id="sidebarBackdrop" onclick="closeSidebar()"
         class="fixed inset-0 bg-slate-900/50 backdrop-blur-sm z-40 hidden lg:hidden"></div>

    <!-- Sidebar (drawer on mobile/tablet, persistent on desktop) -->
    <aside id="sidebar"
           class="sidebar fixed lg:static inset-y-0 left-0 w-[280px] max-w-[85vw] bg-white border-r border-slate-100 flex flex-col z-50
                  -translate-x-full lg:translate-x-0 transition-transform duration-300 ease-out">

        <!-- Mobile close button (visible only when drawer open) -->
        <button type="button" onclick="closeSidebar()" aria-label="Close menu"
                class="lg:hidden absolute top-4 right-4 w-10 h-10 rounded-2xl bg-slate-50 hover:bg-slate-100 text-slate-500 flex items-center justify-center transition-colors">
            <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M18 6 6 18M6 6l12 12"/></svg>
        </button>

        <!-- Logo and role badge -->
        <div class="px-6 lg:px-8 pt-8 lg:pt-10 pb-6 lg:pb-8 flex flex-col items-center">
            <img src="<%= ctx %>/images/Logo.png" alt="Logo" class="w-16 h-16 lg:w-20 lg:h-20 object-contain mb-3 lg:mb-4 transition-transform hover:scale-105" />

            <div class="inline-flex items-center px-3 py-1 rounded-full text-[0.6rem] font-black bg-slate-100 text-slate-500 uppercase tracking-widest">
                <%= "admin".equals(role) ? "System Admin" : "Student Member" %>
            </div>
        </div>

        <!-- Navigation -->
        <nav class="flex-1 px-4 py-4 flex flex-col gap-1.5 overflow-y-auto">
        <% if ("admin".equals(role)) { %>

            <a href="<%= ctx %>/admin"
               class="flex items-center gap-4 px-5 py-4 rounded-2xl text-[0.95rem] font-bold transition-all
                      <%= "dashboard".equals(activePage)
                          ? "bg-brand text-white shadow-[0_4px_0_0_rgb(66,153,2)] translate-y-[-1px]"
                          : "text-slate-500 hover:bg-slate-50" %>">
                <svg class="w-5 h-5 shrink-0 stroke-current" viewBox="0 0 24 24" fill="none" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="7" height="7" rx="2"/><rect x="14" y="3" width="7" height="7" rx="2"/><rect x="3" y="14" width="7" height="7" rx="2"/><rect x="14" y="14" width="7" height="7" rx="2"/></svg>
                <span>Dashboard</span>
            </a>

            <a href="<%= ctx %>/admin/courses"
               class="flex items-center gap-4 px-5 py-4 rounded-2xl text-[0.95rem] font-bold transition-all
                      <%= "courses".equals(activePage)
                          ? "bg-brand text-white shadow-[0_4px_0_0_rgb(66,153,2)] translate-y-[-1px]"
                          : "text-slate-500 hover:bg-slate-50" %>">
                <svg class="w-5 h-5 shrink-0 stroke-current" viewBox="0 0 24 24" fill="none" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M4 19.5v-15A2.5 2.5 0 0 1 6.5 2H20v20H6.5a2.5 2.5 0 0 1 0-5H20"/><path d="M8 7h6"/><path d="M8 11h4"/></svg>
                <span>Courses</span>
            </a>

            <a href="<%= ctx %>/admin/enrollments"
               class="flex items-center gap-4 px-5 py-4 rounded-2xl text-[0.95rem] font-bold transition-all
                      <%= "enrollments".equals(activePage)
                          ? "bg-brand text-white shadow-[0_4px_0_0_rgb(66,153,2)] translate-y-[-1px]"
                          : "text-slate-500 hover:bg-slate-50" %>">
                <svg class="w-5 h-5 shrink-0 stroke-current" viewBox="0 0 24 24" fill="none" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
                <span>Enrollments</span>
            </a>

            <a href="<%= ctx %>/admin?action=students"
               class="flex items-center gap-4 px-5 py-4 rounded-2xl text-[0.95rem] font-bold transition-all
                      <%= "students".equals(activePage)
                          ? "bg-brand text-white shadow-[0_4px_0_0_rgb(66,153,2)] translate-y-[-1px]"
                          : "text-slate-500 hover:bg-slate-50" %>">
                <svg class="w-5 h-5 shrink-0 stroke-current" viewBox="0 0 24 24" fill="none" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M22 10v6M2 10l10-5 10 5-10 5z"/><path d="M6 12v5c0 2 4 3 6 3s6-1 6-3v-5"/></svg>
                <span>Students</span>
            </a>

            <a href="<%= ctx %>/admin/quizzes"
               class="flex items-center gap-4 px-5 py-4 rounded-2xl text-[0.95rem] font-bold transition-all
                      <%= "quizzes".equals(activePage)
                          ? "bg-brand text-white shadow-[0_4px_0_0_rgb(66,153,2)] translate-y-[-1px]"
                          : "text-slate-500 hover:bg-slate-50" %>">
                <svg class="w-5 h-5 shrink-0 stroke-current" viewBox="0 0 24 24" fill="none" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                <span>Quizzes</span>
            </a>

            <a href="<%= ctx %>/admin/messages"
               class="flex items-center gap-4 px-5 py-4 rounded-2xl text-[0.95rem] font-bold transition-all
                      <%= "messages".equals(activePage)
                          ? "bg-brand text-white shadow-[0_4px_0_0_rgb(66,153,2)] translate-y-[-1px]"
                          : "text-slate-500 hover:bg-slate-50" %>">
                <svg class="w-5 h-5 shrink-0 stroke-current" viewBox="0 0 24 24" fill="none" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/></svg>
                <span>Messages</span>
            </a>

            <a href="<%= ctx %>/admin/profile"
               class="flex items-center gap-4 px-5 py-4 rounded-2xl text-[0.95rem] font-bold transition-all
                      <%= "profile".equals(activePage)
                          ? "bg-brand text-white shadow-[0_4px_0_0_rgb(66,153,2)] translate-y-[-1px]"
                          : "text-slate-500 hover:bg-slate-50" %>">
                <svg class="w-5 h-5 shrink-0 stroke-current" viewBox="0 0 24 24" fill="none" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="8" r="5"/><path d="M20 21a8 8 0 0 0-16 0"/></svg>
                <span>My Profile</span>
            </a>

            <a href="<%= ctx %>/about"
               class="flex items-center gap-4 px-5 py-4 rounded-2xl text-[0.95rem] font-bold transition-all
                      <%= "about".equals(activePage)
                          ? "bg-brand text-white shadow-[0_4px_0_0_rgb(66,153,2)] translate-y-[-1px]"
                          : "text-slate-500 hover:bg-slate-50" %>">
                <svg class="w-5 h-5 shrink-0 stroke-current" viewBox="0 0 24 24" fill="none" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><path d="M12 16v-4"/><path d="M12 8h.01"/></svg>
                <span>About</span>
            </a>

        <% } else { %>

            <a href="<%= ctx %>/student"
               class="flex items-center gap-4 px-5 py-4 rounded-2xl text-[0.95rem] font-bold transition-all
                      <%= "dashboard".equals(activePage)
                          ? "bg-brand text-white shadow-[0_4px_0_0_rgb(66,153,2)] translate-y-[-1px]"
                          : "text-slate-500 hover:bg-slate-50" %>">
                <svg class="w-5 h-5 shrink-0 stroke-current" viewBox="0 0 24 24" fill="none" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="7" height="7" rx="2"/><rect x="14" y="3" width="7" height="7" rx="2"/><rect x="3" y="14" width="7" height="7" rx="2"/><rect x="14" y="14" width="7" height="7" rx="2"/></svg>
                <span>Dashboard</span>
            </a>

            <a href="<%= ctx %>/student/courses"
               class="flex items-center gap-4 px-5 py-4 rounded-2xl text-[0.95rem] font-bold transition-all
                      <%= "mycourses".equals(activePage)
                          ? "bg-brand text-white shadow-[0_4px_0_0_rgb(66,153,2)] translate-y-[-1px]"
                          : "text-slate-500 hover:bg-slate-50" %>">
                <svg class="w-5 h-5 shrink-0 stroke-current" viewBox="0 0 24 24" fill="none" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M4 19.5v-15A2.5 2.5 0 0 1 6.5 2H20v20H6.5a2.5 2.5 0 0 1 0-5H20"/><path d="M8 7h6"/><path d="M8 11h4"/></svg>
                <span>My Courses</span>
            </a>

            <a href="<%= ctx %>/student/profile"
               class="flex items-center gap-4 px-5 py-4 rounded-2xl text-[0.95rem] font-bold transition-all
                      <%= "profile".equals(activePage)
                          ? "bg-brand text-white shadow-[0_4px_0_0_rgb(66,153,2)] translate-y-[-1px]"
                          : "text-slate-500 hover:bg-slate-50" %>">
                <svg class="w-5 h-5 shrink-0 stroke-current" viewBox="0 0 24 24" fill="none" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="8" r="5"/><path d="M20 21a8 8 0 0 0-16 0"/></svg>
                <span>My Profile</span>
            </a>

            <a href="<%= ctx %>/about"
               class="flex items-center gap-4 px-5 py-4 rounded-2xl text-[0.95rem] font-bold transition-all
                      <%= "about".equals(activePage)
                          ? "bg-brand text-white shadow-[0_4px_0_0_rgb(66,153,2)] translate-y-[-1px]"
                          : "text-slate-500 hover:bg-slate-50" %>">
                <svg class="w-5 h-5 shrink-0 stroke-current" viewBox="0 0 24 24" fill="none" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><path d="M12 16v-4"/><path d="M12 8h.01"/></svg>
                <span>About</span>
            </a>

            <a href="<%= ctx %>/contact"
               class="flex items-center gap-4 px-5 py-4 rounded-2xl text-[0.95rem] font-bold transition-all
                      <%= "contact".equals(activePage)
                          ? "bg-brand text-white shadow-[0_4px_0_0_rgb(66,153,2)] translate-y-[-1px]"
                          : "text-slate-500 hover:bg-slate-50" %>">
                <svg class="w-5 h-5 shrink-0 stroke-current" viewBox="0 0 24 24" fill="none" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/></svg>
                <span>Contact</span>
            </a>

        <% } %>
        </nav>

        <!-- User card -->
        <div class="mx-4 mt-2 px-4 lg:px-5 py-4 lg:py-5 rounded-3xl flex items-center gap-3 lg:gap-4 bg-slate-50 border border-slate-100">
            <% if (hasPhoto) { %>
                <img src="<%= ctx %>/photo?userId=<%= userIdS %>" alt="Profile"
                     class="w-12 h-12 min-w-[48px] rounded-2xl object-cover ring-2 ring-white shadow-sm"
                     onerror="this.onerror=null; this.src='https://api.dicebear.com/7.x/initials/svg?seed=<%= userName %>';" />
            <% } else { %>
                <div class="w-12 h-12 min-w-[48px] rounded-2xl bg-brand flex items-center justify-center text-white font-black text-lg ring-2 ring-white shadow-sm">
                    <%= userName.isEmpty() ? "?" : userName.substring(0, 1).toUpperCase() %>
                </div>
            <% } %>
            <div class="flex flex-col min-w-0">
                <span class="text-slate-800 text-[0.95rem] font-bold truncate"><%= userName %></span>
                <span class="text-slate-500 font-bold text-[0.65rem] uppercase tracking-wider"><%= "admin".equals(role) ? "Administrator" : "Student" %></span>
            </div>
        </div>

        <!-- Sign Out -->
        <div class="px-4 pb-6 lg:pb-10 pt-3 lg:pt-4">
            <a href="<%= ctx %>/logout"
               class="flex items-center gap-3 px-5 py-4 rounded-2xl text-[0.95rem] font-bold text-slate-400 hover:text-red-500 hover:bg-red-50 transition-all">
                <svg class="w-5 h-5 shrink-0 stroke-current" viewBox="0 0 24 24" fill="none" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
                <span>Sign Out</span>
            </a>
        </div>
    </aside>

    <script>
        function openSidebar() {
            var s = document.getElementById('sidebar');
            var b = document.getElementById('sidebarBackdrop');
            if (s) { s.classList.remove('-translate-x-full'); s.classList.add('translate-x-0'); }
            if (b) { b.classList.remove('hidden'); }
            document.body.style.overflow = 'hidden';
        }
        function closeSidebar() {
            var s = document.getElementById('sidebar');
            var b = document.getElementById('sidebarBackdrop');
            if (s) { s.classList.add('-translate-x-full'); s.classList.remove('translate-x-0'); }
            if (b) { b.classList.add('hidden'); }
            document.body.style.overflow = '';
        }
        // Reset drawer state on viewport change so it never gets stuck visible without backdrop
        window.addEventListener('resize', function() {
            var s = document.getElementById('sidebar');
            var b = document.getElementById('sidebarBackdrop');
            if (window.innerWidth >= 1024) {
                if (b) b.classList.add('hidden');
                document.body.style.overflow = '';
            } else {
                // Returning to mobile: collapse drawer and clear the open-state classes
                if (s) { s.classList.add('-translate-x-full'); s.classList.remove('translate-x-0'); }
                if (b) b.classList.add('hidden');
                document.body.style.overflow = '';
            }
        });
        // Close when clicking a nav link inside the drawer (mobile only)
        document.addEventListener('DOMContentLoaded', function() {
            var sidebar = document.getElementById('sidebar');
            if (!sidebar) return;
            sidebar.querySelectorAll('nav a').forEach(function(a) {
                a.addEventListener('click', function() {
                    if (window.innerWidth < 1024) closeSidebar();
                });
            });
        });
    </script>

    <!-- Main content area -->
    <main class="flex-1 flex flex-col h-full bg-slate-50 relative overflow-y-auto w-full min-w-0">
        <header class="min-h-[64px] sm:min-h-[72px] lg:h-[84px] flex-shrink-0 flex items-center justify-between gap-3 px-4 sm:px-6 lg:px-10 py-3 sm:py-4 sticky top-0 z-30 bg-slate-50/80 backdrop-blur-md">
            <div class="flex items-center gap-3 min-w-0 flex-1">
                <!-- Hamburger (mobile/tablet only) -->
                <button type="button" onclick="openSidebar()" aria-label="Open menu"
                        class="lg:hidden shrink-0 w-10 h-10 rounded-2xl bg-white hover:bg-slate-100 ring-1 ring-slate-100 text-slate-600 flex items-center justify-center transition-colors">
                    <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="3" y1="6" x2="21" y2="6"/><line x1="3" y1="12" x2="21" y2="12"/><line x1="3" y1="18" x2="21" y2="18"/></svg>
                </button>
                <div class="min-w-0">
                    <h1 class="text-lg sm:text-xl lg:text-2xl font-black text-slate-900 tracking-tight truncate"><%= pageTitle %></h1>
                    <p class="hidden sm:block text-xs font-bold text-slate-500 mt-1 uppercase tracking-widest leading-none truncate"><%= "dashboard".equals(activePage) ? "Overview and summary" : "Manage your " + activePage %></p>
                </div>
            </div>
            <div class="flex items-center gap-3 sm:gap-6 shrink-0">
                <span class="text-sm font-bold text-slate-400 hidden xl:block italic">Welcome back, <strong class="text-slate-900 not-italic"><%= userName %></strong></span>
                <div class="relative w-10 h-10 sm:w-12 sm:h-12 rounded-2xl overflow-hidden ring-2 ring-white shadow-sm flex items-center justify-center bg-brand text-white font-black text-base sm:text-lg">
                    <% if (hasPhoto) { %>
                        <img src="<%= ctx %>/photo?userId=<%= userIdS %>" alt="Profile" class="absolute inset-0 w-full h-full object-cover z-10"
                             onerror="this.onerror=null; this.src='https://api.dicebear.com/7.x/initials/svg?seed=<%= userName %>';" />
                    <% } %>
                    <span class="z-0"><%= userName.isEmpty() ? "?" : userName.substring(0, 1).toUpperCase() %></span>
                </div>
            </div>
        </header>
        <div class="content px-4 sm:px-6 lg:px-10 pb-6 sm:pb-8 lg:pb-10 pt-2 sm:pt-3 lg:pt-4 flex-1 min-w-0">

