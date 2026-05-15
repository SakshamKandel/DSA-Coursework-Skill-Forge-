<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.skillforge.model.Enrollment, java.util.List" %>
<%
    request.setAttribute("pageTitle", "Admin Dashboard");
    request.setAttribute("activePage", "dashboard");
%>
<%@ include file="/WEB-INF/pages/common/header.jsp" %>
<%
    int totalStudents    = (int) request.getAttribute("totalStudents");
    int totalCourses     = (int) request.getAttribute("totalCourses");
    int totalEnrollments = (int) request.getAttribute("totalEnrollments");
    List<Enrollment> recent = (List<Enrollment>) request.getAttribute("recentEnrollments");
%>

<!-- Page content -->
<div class="p-2 sm:p-4 lg:p-10 space-y-8 lg:space-y-12">
    <!-- Summary statistic cards -->
    <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-4 sm:gap-6 lg:gap-10">
        <!-- Total students card -->
        <div class="group bg-white p-6 sm:p-8 lg:p-10 rounded-3xl lg:rounded-[3rem] shadow-[0_8px_30px_rgb(0,0,0,0.04)] ring-1 ring-slate-100 hover:translate-y-[-10px] transition-all duration-500">
            <div class="flex items-center gap-4 sm:gap-5 mb-6 lg:mb-8">
                <div class="w-12 h-12 sm:w-14 sm:h-14 shrink-0 rounded-2xl bg-blue-50 text-blue-600 flex items-center justify-center">
                    <svg class="w-6 h-6 sm:w-7 sm:h-7" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
                </div>
                <div class="min-w-0">
                    <h3 class="text-[0.7rem] font-black text-slate-400 uppercase tracking-[0.2em]">Total Students</h3>
                    <p class="text-xs font-bold text-slate-300 mt-1 uppercase tracking-widest">Registered students</p>
                </div>
            </div>
            <div class="text-4xl sm:text-5xl lg:text-6xl font-black text-slate-800 tabular-nums"><%= totalStudents %></div>
        </div>

        <!-- Total courses card -->
        <div class="group bg-white p-6 sm:p-8 lg:p-10 rounded-3xl lg:rounded-[3rem] shadow-[0_8px_30px_rgb(0,0,0,0.04)] ring-1 ring-slate-100 hover:translate-y-[-10px] transition-all duration-500">
            <div class="flex items-center gap-4 sm:gap-5 mb-6 lg:mb-8">
                <div class="w-12 h-12 sm:w-14 sm:h-14 shrink-0 rounded-2xl bg-brand/10 text-brand flex items-center justify-center">
                    <svg class="w-6 h-6 sm:w-7 sm:h-7" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><path d="M4 19.5v-15A2.5 2.5 0 0 1 6.5 2H20v20H6.5a2.5 2.5 0 0 1 0-5H20"/><path d="M8 7h6"/><path d="M8 11h4"/></svg>
                </div>
                <div class="min-w-0">
                    <h3 class="text-[0.7rem] font-black text-slate-400 uppercase tracking-[0.2em]">Active Courses</h3>
                    <p class="text-xs font-bold text-brand mt-1 uppercase tracking-widest">Available now</p>
                </div>
            </div>
            <div class="text-4xl sm:text-5xl lg:text-6xl font-black text-slate-800 tabular-nums"><%= totalCourses %></div>
        </div>

        <!-- Total enrollments card -->
        <div class="group bg-white p-6 sm:p-8 lg:p-10 rounded-3xl lg:rounded-[3rem] shadow-[0_8px_30px_rgb(0,0,0,0.04)] ring-1 ring-slate-100 hover:translate-y-[-10px] transition-all duration-500 sm:col-span-2 xl:col-span-1">
            <div class="flex items-center gap-4 sm:gap-5 mb-6 lg:mb-8">
                <div class="w-12 h-12 sm:w-14 sm:h-14 shrink-0 rounded-2xl bg-amber-50 text-amber-500 flex items-center justify-center">
                    <svg class="w-6 h-6 sm:w-7 sm:h-7" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/><polyline points="10 9 9 9 8 9"/></svg>
                </div>
                <div class="min-w-0">
                    <h3 class="text-[0.7rem] font-black text-slate-400 uppercase tracking-[0.2em]">Enrollments</h3>
                    <p class="text-xs font-bold text-amber-400 mt-1 uppercase tracking-widest">Total enrolments</p>
                </div>
            </div>
            <div class="text-4xl sm:text-5xl lg:text-6xl font-black text-slate-800 tabular-nums"><%= totalEnrollments %></div>
        </div>
    </div>

    <!-- Recent enrollments list -->
    <section>
        <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3 mb-6 lg:mb-8">
            <div>
                <h2 class="text-xl sm:text-2xl font-black text-slate-800 tracking-tight">Recent Enrollments</h2>
                <p class="text-[0.7rem] font-black text-slate-400 uppercase tracking-widest mt-2">Latest student enrollments</p>
            </div>
            <a href="<%= ctx %>/admin/enrollments" class="text-xs font-black text-brand uppercase tracking-widest hover:underline underline-offset-8 decoration-2 decoration-brand/30 self-start sm:self-auto">View All</a>
        </div>

        <div class="bg-white rounded-3xl lg:rounded-[2.5rem] overflow-hidden shadow-[0_8px_30px_rgb(0,0,0,0.04)] ring-1 ring-slate-100">
            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse min-w-[640px]">
                    <thead>
                        <tr class="bg-slate-50/50">
                            <th class="px-5 sm:px-8 lg:px-10 py-4 lg:py-6 text-[0.7rem] font-black text-slate-400 uppercase tracking-widest">Student</th>
                            <th class="px-5 sm:px-8 lg:px-10 py-4 lg:py-6 text-[0.7rem] font-black text-slate-400 uppercase tracking-widest">Course</th>
                            <th class="px-5 sm:px-8 lg:px-10 py-4 lg:py-6 text-[0.7rem] font-black text-slate-400 uppercase tracking-widest text-center">Status</th>
                            <th class="px-5 sm:px-8 lg:px-10 py-4 lg:py-6 text-[0.7rem] font-black text-slate-400 uppercase tracking-widest text-right">Date</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-50">
                    <% if (recent != null && !recent.isEmpty()) {
                        for (Enrollment en : recent) { %>
                        <tr class="group hover:bg-slate-50/30 transition-colors">
                            <td class="px-5 sm:px-8 lg:px-10 py-5 lg:py-8">
                                <div class="font-black text-slate-800 leading-tight"><%= en.getStudentName() %></div>
                                <div class="text-slate-400 text-[0.65rem] font-black mt-1 uppercase tracking-widest">Registered student</div>
                            </td>
                            <td class="px-5 sm:px-8 lg:px-10 py-5 lg:py-8">
                                <div class="text-sm font-bold text-slate-600 truncate max-w-xs"><%= en.getCourseTitle() %></div>
                            </td>
                            <td class="px-5 sm:px-8 lg:px-10 py-5 lg:py-8 text-center">
                                <span class="inline-flex px-3 sm:px-4 py-1.5 sm:py-2 rounded-xl text-[0.65rem] font-black uppercase tracking-widest
                                    <%= "active".equals(en.getStatus()) ? "bg-brand/10 text-brand" : "completed".equals(en.getStatus()) ? "bg-amber-50 text-amber-600" : "bg-red-50 text-red-600" %>">
                                    <%= en.getStatus() %>
                                </span>
                            </td>
                            <td class="px-5 sm:px-8 lg:px-10 py-5 lg:py-8 text-right text-xs font-black text-slate-400 tabular-nums">
                                <%= en.getEnrolledAt() %>
                            </td>
                        </tr>
                    <% } } else { %>
                        <tr><td colspan="4" class="px-5 sm:px-8 lg:px-10 py-16 lg:py-24 text-center">
                            <div class="w-16 h-16 lg:w-20 lg:h-20 bg-slate-50 rounded-3xl lg:rounded-[2rem] flex items-center justify-center mx-auto mb-4 lg:mb-6 text-slate-200">
                                <svg class="w-8 h-8 lg:w-10 lg:h-10" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24"><path d="M12 8v4l3 3m6-3a9 9 0 1 1-18 0 9 9 0 0 1 18 0z"/></svg>
                            </div>
                            <p class="text-sm font-black text-slate-400 uppercase tracking-[0.2em]">No recent enrollments</p>
                        </td></tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </section>
</div>

<%@ include file="/WEB-INF/pages/common/footer.jsp" %>
