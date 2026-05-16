<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.skillforge.model.Certification" %>
<%
    Certification cert = (Certification) request.getAttribute("cert");
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Certificate of Completion - SkillForge</title>
    <script src="<%= ctx %>/js/tailwind.js"></script>
    <link rel="stylesheet" href="<%= ctx %>/css/style.css?v=2.4" />
</head>
<body class="cert-print p-3 sm:p-8 lg:p-20 flex flex-col items-center">

    <div class="no-print mb-6 sm:mb-10 flex flex-col sm:flex-row gap-3 sm:gap-4 w-full max-w-[1000px]">
        <button onclick="window.print()" class="bg-slate-900 text-white px-6 sm:px-8 py-3 rounded-xl font-bold hover:bg-slate-800 transition-all flex items-center justify-center gap-2 text-sm sm:text-base">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M6 9V2h12v7M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2m-12 0v4h10v-4M9 14h6"/></svg>
            Print Certificate
        </button>
        <a href="<%= ctx %>/student/courses" class="bg-white border text-slate-600 px-6 sm:px-8 py-3 rounded-xl font-bold hover:bg-slate-50 transition-all inline-flex items-center justify-center text-sm sm:text-base">
            Back to Dashboard
        </a>
    </div>

    <!-- Certificate body: drops fixed aspect ratio on mobile so content can flow naturally -->
    <div class="cert-container bg-white w-full max-w-[1000px] md:aspect-[1.414/1] shadow-2xl relative overflow-hidden cert-border p-6 sm:p-12 lg:p-20 flex flex-col items-center justify-between text-center gap-8 md:gap-0">

        <!-- Decorative corner borders -->
        <div class="absolute top-0 left-0 w-20 h-20 sm:w-32 sm:h-32 lg:w-40 lg:h-40 border-t-4 border-l-4 sm:border-t-8 sm:border-l-8 border-emerald-500 opacity-20"></div>
        <div class="absolute bottom-0 right-0 w-20 h-20 sm:w-32 sm:h-32 lg:w-40 lg:h-40 border-b-4 border-r-4 sm:border-b-8 sm:border-r-8 border-emerald-500 opacity-20"></div>

        <div>
            <div class="flex items-center justify-center gap-3 mb-4 sm:mb-6">
                <div class="w-10 h-10 sm:w-12 sm:h-12 bg-slate-900 rounded-xl flex items-center justify-center">
                     <img src="<%= ctx %>/images/Logo.png" alt="Logo" class="w-6 h-6 sm:w-7 sm:h-7" />
                </div>
                <span class="text-xl sm:text-2xl font-black text-slate-900 tracking-tighter uppercase">SkillForge</span>
            </div>
            <h3 class="text-[0.6rem] sm:text-xs font-black text-slate-400 uppercase tracking-[0.3em] sm:tracking-[0.5em] mb-6 sm:mb-12">Certificate of Completion</h3>
        </div>

        <div>
            <p class="text-sm sm:text-base lg:text-lg font-bold text-slate-500 mb-3 sm:mb-4">This is to certify that</p>
            <h1 class="text-3xl sm:text-5xl lg:text-6xl font-black text-slate-900 mb-5 sm:mb-8 tracking-tight break-words"><%= cert.getStudentName() %></h1>
            <p class="text-sm sm:text-base lg:text-lg font-bold text-slate-500 mb-6 sm:mb-12">has successfully completed the course</p>
            <h2 class="text-2xl sm:text-3xl lg:text-4xl cert-font-serif italic text-emerald-600 mb-4 break-words"><%= cert.getCourseTitle() %></h2>
            <div class="w-24 sm:w-32 h-1 bg-slate-100 mx-auto rounded-full"></div>
        </div>

        <div class="w-full flex flex-col sm:flex-row justify-between items-center sm:items-end gap-6 sm:gap-4">
            <!-- Signature -->
            <div class="text-center sm:text-left order-2 sm:order-1">
                <div class="cert-font-serif text-xl sm:text-2xl text-slate-800 mb-1 italic">Ramesh Khatri</div>
                <div class="w-36 sm:w-48 h-[1.5px] bg-slate-200 mb-2 mx-auto sm:mx-0"></div>
                <p class="text-[0.6rem] font-black text-slate-400 uppercase tracking-widest">Academic Director</p>
            </div>

            <!-- Seal -->
            <div class="gold-seal w-24 h-24 sm:w-28 sm:h-28 lg:w-32 lg:h-32 rounded-full border-4 border-white flex items-center justify-center relative scale-110 order-1 sm:order-2 shrink-0">
                <div class="absolute inset-2 border-2 border-white/30 rounded-full border-dashed"></div>
                <svg class="w-10 h-10 sm:w-12 sm:h-12 text-white" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
            </div>

            <!-- Issue date and certificate id -->
            <div class="text-center sm:text-right order-3">
                <p class="text-[0.6rem] font-black text-slate-400 uppercase tracking-widest mb-1">Issue Date: <%= cert.getIssuedAt() %></p>
                <p class="text-[0.6rem] font-black text-slate-800 uppercase tracking-widest break-all">ID: <%= cert.getCertCode() %></p>
            </div>
        </div>

        <!-- Background watermark -->
        <div class="absolute inset-0 flex items-center justify-center -z-10 opacity-[0.03] pointer-events-none">
            <span class="text-[8rem] sm:text-[14rem] lg:text-[20rem] font-black rotate-[-15deg] select-none">FORGE</span>
        </div>
    </div>

</body>
</html>
