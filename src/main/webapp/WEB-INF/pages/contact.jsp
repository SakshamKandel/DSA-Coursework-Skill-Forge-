<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("pageTitle", "Contact Us");
    request.setAttribute("activePage", "contact");

    String success = (String) request.getAttribute("success");
    String error   = (String) request.getAttribute("error");

    /* Repopulate form on validation failure */
    String oldName    = (request.getAttribute("fullName") != null) ? (String) request.getAttribute("fullName") : "";
    String oldEmail   = (request.getAttribute("email")    != null) ? (String) request.getAttribute("email")    : "";
    String oldSubject = (request.getAttribute("subject")  != null) ? (String) request.getAttribute("subject")  : "";
    String oldMessage = (request.getAttribute("message")  != null) ? (String) request.getAttribute("message")  : "";
%>
<%@ include file="/WEB-INF/pages/common/header.jsp" %>

<!-- Contact page content -->
<div class="p-2 sm:p-4 lg:p-10 space-y-8 lg:space-y-12">

    <!-- Hero Section -->
    <div class="bg-white rounded-3xl lg:rounded-[3rem] overflow-hidden shadow-[0_8px_30px_rgb(0,0,0,0.04)] ring-1 ring-slate-100">
        <div class="h-32 sm:h-40 lg:h-48 bg-slate-900 relative overflow-hidden">
            <div class="absolute inset-0 bg-[radial-gradient(circle_at_30%_50%,#58cc0220_0%,transparent_50%),radial-gradient(circle_at_70%_50%,#1cb0f620_0%,transparent_50%)]"></div>
        </div>
        <div class="px-6 sm:px-8 lg:px-12 pb-6 sm:pb-8 lg:pb-12 -mt-12 sm:-mt-14 lg:-mt-16 relative">
            <div class="w-20 h-20 sm:w-24 sm:h-24 bg-brand rounded-3xl lg:rounded-[2rem] flex items-center justify-center shadow-xl mb-5 lg:mb-6 border-[6px] border-white">
                <svg class="w-10 h-10 sm:w-12 sm:h-12 text-white" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                    <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/>
                    <polyline points="22,6 12,13 2,6"/>
                </svg>
            </div>
            <h2 class="text-2xl sm:text-3xl lg:text-4xl font-black text-slate-800 tracking-tight mb-3 sm:mb-4">Get In Touch</h2>
            <p class="text-sm sm:text-base lg:text-lg font-bold text-slate-500 max-w-3xl leading-relaxed">
                Have a question about a course, your account, or the platform? Our support team
                is here to help. Send us a message using the form below or reach out directly
                through any of the channels listed.
            </p>
        </div>
    </div>

    <!-- Support Channels Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-5 sm:gap-6 lg:gap-10">
        <!-- Email -->
        <div class="bg-white p-6 sm:p-8 lg:p-10 rounded-3xl lg:rounded-[2.5rem] shadow-[0_8px_30px_rgb(0,0,0,0.04)] ring-1 ring-slate-100">
            <div class="w-12 h-12 sm:w-14 sm:h-14 rounded-2xl bg-brand/10 flex items-center justify-center text-brand mb-5 lg:mb-6">
                <svg class="w-6 h-6 sm:w-7 sm:h-7" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                    <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/>
                    <polyline points="22,6 12,13 2,6"/>
                </svg>
            </div>
            <h3 class="text-lg sm:text-xl font-black text-slate-800 mb-3">Email Support</h3>
            <p class="text-sm font-bold text-slate-400 leading-relaxed mb-2">
                For general inquiries and account issues.
            </p>
            <a href="mailto:support@skillforge.com" class="text-sm font-black text-brand hover:underline break-all">
                support@skillforge.com
            </a>
        </div>

        <!-- Phone -->
        <div class="bg-white p-6 sm:p-8 lg:p-10 rounded-3xl lg:rounded-[2.5rem] shadow-[0_8px_30px_rgb(0,0,0,0.04)] ring-1 ring-slate-100">
            <div class="w-12 h-12 sm:w-14 sm:h-14 rounded-2xl bg-blue-50 flex items-center justify-center text-blue-500 mb-5 lg:mb-6">
                <svg class="w-6 h-6 sm:w-7 sm:h-7" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                    <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"/>
                </svg>
            </div>
            <h3 class="text-lg sm:text-xl font-black text-slate-800 mb-3">Phone Support</h3>
            <p class="text-sm font-bold text-slate-400 leading-relaxed mb-2">
                Mon - Fri, 9:00 AM - 6:00 PM (NPT).
            </p>
            <a href="tel:+97714411111" class="text-sm font-black text-blue-500 hover:underline">
                +977 1-441-1111
            </a>
        </div>

        <!-- Address -->
        <div class="bg-white p-6 sm:p-8 lg:p-10 rounded-3xl lg:rounded-[2.5rem] shadow-[0_8px_30px_rgb(0,0,0,0.04)] ring-1 ring-slate-100 md:col-span-2 xl:col-span-1">
            <div class="w-12 h-12 sm:w-14 sm:h-14 rounded-2xl bg-purple-50 flex items-center justify-center text-purple-500 mb-5 lg:mb-6">
                <svg class="w-6 h-6 sm:w-7 sm:h-7" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                    <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/>
                    <circle cx="12" cy="10" r="3"/>
                </svg>
            </div>
            <h3 class="text-lg sm:text-xl font-black text-slate-800 mb-3">Office Address</h3>
            <p class="text-sm font-bold text-slate-400 leading-relaxed">
                SkillForge Academy<br>
                Kamalpokhari, Kathmandu<br>
                Nepal 44600
            </p>
        </div>
    </div>

    <!-- Inquiry Form Section -->
    <div class="bg-white rounded-3xl lg:rounded-[2.5rem] p-6 sm:p-8 lg:p-12 shadow-[0_8px_30px_rgb(0,0,0,0.04)] ring-1 ring-slate-100">
        <div class="max-w-2xl mx-auto">
            <h2 class="text-xl sm:text-2xl font-black text-slate-800 tracking-tight mb-2">Send Us a Message</h2>
            <p class="text-sm font-bold text-slate-400 mb-6 sm:mb-8">
                Fill out the form and our team will respond within 24 hours.
            </p>

            <% if (success != null) { %>
                <div class="bg-brand text-white p-4 sm:p-5 rounded-2xl sm:rounded-3xl shadow-[0_6px_0_0_rgba(66,153,2,1)] font-bold text-sm mb-6 sm:mb-8">
                    &#10003; <%= success %>
                </div>
            <% } %>

            <% if (error != null) { %>
                <div class="bg-red-500 text-white p-4 sm:p-5 rounded-2xl sm:rounded-3xl shadow-[0_6px_0_0_rgba(185,28,28,1)] font-bold text-sm mb-6 sm:mb-8">
                    &#10007; <%= error %>
                </div>
            <% } %>

            <form action="<%= ctx %>/contact" method="post" class="space-y-5 sm:space-y-6">

                <div class="grid grid-cols-1 md:grid-cols-2 gap-5 sm:gap-6">
                    <div>
                        <label class="block text-xs font-black text-slate-500 uppercase tracking-widest mb-3">Your Name</label>
                        <input type="text" name="fullName" value="<%= oldName %>" required
                               maxlength="100"
                               placeholder="Jane Doe"
                               class="w-full rounded-2xl border-2 border-slate-100 p-4 font-bold text-slate-800 focus:border-brand focus:ring-4 focus:ring-brand/10 outline-none transition-all" />
                    </div>
                    <div>
                        <label class="block text-xs font-black text-slate-500 uppercase tracking-widest mb-3">Email Address</label>
                        <input type="email" name="email" value="<%= oldEmail %>" required
                               maxlength="150"
                               placeholder="jane@example.com"
                               class="w-full rounded-2xl border-2 border-slate-100 p-4 font-bold text-slate-800 focus:border-brand focus:ring-4 focus:ring-brand/10 outline-none transition-all" />
                    </div>
                </div>

                <div>
                    <label class="block text-xs font-black text-slate-500 uppercase tracking-widest mb-3">Subject</label>
                    <input type="text" name="subject" value="<%= oldSubject %>" required
                           maxlength="200"
                           placeholder="Question about course enrollment"
                           class="w-full rounded-2xl border-2 border-slate-100 p-4 font-bold text-slate-800 focus:border-brand focus:ring-4 focus:ring-brand/10 outline-none transition-all" />
                </div>

                <div>
                    <label class="block text-xs font-black text-slate-500 uppercase tracking-widest mb-3">Message</label>
                    <textarea name="message" required rows="6" maxlength="4000"
                              placeholder="Type your message here..."
                              class="w-full rounded-2xl border-2 border-slate-100 p-4 font-bold text-slate-800 focus:border-brand focus:ring-4 focus:ring-brand/10 outline-none transition-all resize-none"><%= oldMessage %></textarea>
                </div>

                <button type="submit"
                        class="w-full bg-brand text-white font-black py-4 sm:py-5 rounded-2xl shadow-[0_6px_0_0_rgba(66,153,2,1)] hover:translate-y-[-2px] active:translate-y-[2px] active:shadow-none transition-all uppercase tracking-widest text-sm sm:text-base">
                    Send Message
                </button>
            </form>
        </div>
    </div>

</div>

<%@ include file="/WEB-INF/pages/common/footer.jsp" %>
