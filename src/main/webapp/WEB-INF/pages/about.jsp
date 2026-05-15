<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("pageTitle", "About SkillForge");
    request.setAttribute("activePage", "about");
%>
<%@ include file="/WEB-INF/pages/common/header.jsp" %>

<!-- About page content -->
<div class="p-2 sm:p-4 lg:p-10 space-y-8 lg:space-y-12">
    <!-- Hero banner -->
    <div class="bg-white rounded-3xl lg:rounded-[3rem] overflow-hidden shadow-[0_8px_30px_rgb(0,0,0,0.04)] ring-1 ring-slate-100">
        <div class="h-32 sm:h-40 lg:h-48 bg-slate-900 relative overflow-hidden">
            <div class="absolute inset-0 bg-[radial-gradient(circle_at_30%_50%,#58cc0220_0%,transparent_50%),radial-gradient(circle_at_70%_50%,#1cb0f620_0%,transparent_50%)]"></div>
        </div>
        <div class="px-6 sm:px-8 lg:px-12 pb-6 sm:pb-8 lg:pb-12 -mt-12 sm:-mt-14 lg:-mt-16 relative">
            <div class="w-20 h-20 sm:w-24 sm:h-24 bg-brand rounded-3xl lg:rounded-[2rem] flex items-center justify-center shadow-xl mb-5 lg:mb-6 border-[6px] border-white">
                <img src="<%= ctx %>/images/Logo.png" alt="Logo" class="w-12 h-12 sm:w-14 sm:h-14 object-contain" />
            </div>
            <h2 class="text-2xl sm:text-3xl lg:text-4xl font-black text-slate-800 tracking-tight mb-3 sm:mb-4">About SkillForge</h2>
            <p class="text-sm sm:text-base lg:text-lg font-bold text-slate-500 max-w-3xl leading-relaxed">
                SkillForge is an Online Course Enrollment and Progress Tracking System built as a
                Java Dynamic Web Application. It demonstrates enterprise-grade software engineering
                practices using the MVC architectural pattern, Jakarta EE, and MySQL.
            </p>
        </div>
    </div>

    <!-- Feature cards -->
    <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-5 sm:gap-6 lg:gap-10">
        <!-- Course management -->
        <div class="bg-white p-6 sm:p-8 lg:p-10 rounded-3xl lg:rounded-[2.5rem] shadow-[0_8px_30px_rgb(0,0,0,0.04)] ring-1 ring-slate-100">
            <div class="w-12 h-12 sm:w-14 sm:h-14 rounded-2xl bg-brand/10 flex items-center justify-center text-brand mb-5 lg:mb-6">
                <svg class="w-6 h-6 sm:w-7 sm:h-7" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><path d="M4 19.5v-15A2.5 2.5 0 0 1 6.5 2H20v20H6.5a2.5 2.5 0 0 1 0-5H20"/><path d="M8 7h6"/><path d="M8 11h4"/></svg>
            </div>
            <h3 class="text-lg sm:text-xl font-black text-slate-800 mb-3">Course Management</h3>
            <p class="text-sm font-bold text-slate-400 leading-relaxed">
                Admins can create, update, and delete courses with categories and instructor assignments.
                Students can browse, enroll, track progress, and drop courses.
            </p>
        </div>

        <!-- Quizzes and certificates -->
        <div class="bg-white p-6 sm:p-8 lg:p-10 rounded-3xl lg:rounded-[2.5rem] shadow-[0_8px_30px_rgb(0,0,0,0.04)] ring-1 ring-slate-100">
            <div class="w-12 h-12 sm:w-14 sm:h-14 rounded-2xl bg-blue-50 flex items-center justify-center text-blue-500 mb-5 lg:mb-6">
                <svg class="w-6 h-6 sm:w-7 sm:h-7" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
            </div>
            <h3 class="text-lg sm:text-xl font-black text-slate-800 mb-3">Quizzes &amp; Certificates</h3>
            <p class="text-sm font-bold text-slate-400 leading-relaxed">
                Students earn certificates by passing course quizzes. Each quiz features multiple-choice
                questions with instant grading and a unique certification code on pass.
            </p>
        </div>

        <!-- Security and authentication -->
        <div class="bg-white p-6 sm:p-8 lg:p-10 rounded-3xl lg:rounded-[2.5rem] shadow-[0_8px_30px_rgb(0,0,0,0.04)] ring-1 ring-slate-100 md:col-span-2 xl:col-span-1">
            <div class="w-12 h-12 sm:w-14 sm:h-14 rounded-2xl bg-purple-50 flex items-center justify-center text-purple-500 mb-5 lg:mb-6">
                <svg class="w-6 h-6 sm:w-7 sm:h-7" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><rect width="18" height="11" x="3" y="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
            </div>
            <h3 class="text-lg sm:text-xl font-black text-slate-800 mb-3">Security &amp; Auth</h3>
            <p class="text-sm font-bold text-slate-400 leading-relaxed">
                AES-128 password encryption, role-based access control via Servlet Filter,
                account lockout after 5 failed attempts, and forgot-password with token reset.
            </p>
        </div>
    </div>

    <!-- Frequently asked questions -->
    <div class="bg-white rounded-3xl lg:rounded-[2.5rem] p-6 sm:p-8 lg:p-12 shadow-[0_8px_30px_rgb(0,0,0,0.04)] ring-1 ring-slate-100">
        <h2 class="text-xl sm:text-2xl font-black text-slate-800 tracking-tight mb-6 lg:mb-8">Frequently Asked Questions</h2>
        <div class="space-y-4 sm:space-y-6">
            <div class="p-5 sm:p-6 bg-slate-50 rounded-2xl">
                <h4 class="font-black text-slate-700 mb-2">How do I enroll in a course?</h4>
                <p class="text-sm font-bold text-slate-400">Navigate to "My Courses" from the sidebar, scroll to the catalog section, and click the "Enroll" button on any available course.</p>
            </div>
            <div class="p-5 sm:p-6 bg-slate-50 rounded-2xl">
                <h4 class="font-black text-slate-700 mb-2">How are passwords stored?</h4>
                <p class="text-sm font-bold text-slate-400">All passwords are encrypted using AES-128 (ECB mode with PKCS5 padding) before being stored in the database. Plain-text passwords are never saved.</p>
            </div>
            <div class="p-5 sm:p-6 bg-slate-50 rounded-2xl">
                <h4 class="font-black text-slate-700 mb-2">What happens after 5 failed login attempts?</h4>
                <p class="text-sm font-bold text-slate-400">Your account will be automatically locked for security. An administrator must manually unlock it from the admin dashboard.</p>
            </div>
            <div class="p-5 sm:p-6 bg-slate-50 rounded-2xl">
                <h4 class="font-black text-slate-700 mb-2">How do I earn a certificate?</h4>
                <p class="text-sm font-bold text-slate-400">Complete your course progress to 100%, then take the associated quiz. If you score above the passing threshold, a unique certificate is automatically generated.</p>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/pages/common/footer.jsp" %>
