<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.skillforge.model.Enrollment, java.util.List" %>
<%
    request.setAttribute("pageTitle", "Manage Enrollments");
    request.setAttribute("activePage", "enrollments");
%>
<%@ include file="/WEB-INF/pages/common/header.jsp" %>
<%
    List<Enrollment> enrollments = (List<Enrollment>) request.getAttribute("enrollments");
%>

<!-- Page content -->
<div class="p-2 sm:p-4 lg:p-10">
    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 mb-6 lg:mb-10">
        <div>
            <h2 class="text-xl sm:text-2xl lg:text-3xl font-black text-slate-800 tracking-tight">Manage Enrollments</h2>
            <p class="text-[0.7rem] font-black text-slate-400 uppercase tracking-widest mt-2">All student course enrollments</p>
        </div>
        <div class="flex flex-wrap gap-3 sm:gap-4">
            <div class="px-4 sm:px-6 py-3 sm:py-4 rounded-2xl bg-white shadow-sm ring-1 ring-slate-100 flex items-center gap-3">
                <span class="text-[0.7rem] font-black text-slate-400 uppercase tracking-widest border-r border-slate-100 pr-3">Total</span>
                <span class="text-sm font-black text-slate-800"><%= enrollments != null ? enrollments.size() : 0 %> records</span>
            </div>
        </div>
    </div>

    <div class="bg-white rounded-3xl lg:rounded-[2.5rem] overflow-hidden shadow-[0_8px_30px_rgb(0,0,0,0.04)] ring-1 ring-slate-100">
        <div class="overflow-x-auto">
            <table class="w-full text-left border-collapse min-w-[760px]">
                <thead>
                    <tr class="bg-slate-50/50">
                        <th class="px-5 sm:px-8 py-4 lg:py-6 text-[0.7rem] font-black text-slate-400 uppercase tracking-widest">Student</th>
                        <th class="px-5 sm:px-8 py-4 lg:py-6 text-[0.7rem] font-black text-slate-400 uppercase tracking-widest">Course</th>
                        <th class="px-5 sm:px-8 py-4 lg:py-6 text-[0.7rem] font-black text-slate-400 uppercase tracking-widest text-center">Progress</th>
                        <th class="px-5 sm:px-8 py-4 lg:py-6 text-[0.7rem] font-black text-slate-400 uppercase tracking-widest text-center">Status</th>
                        <th class="px-5 sm:px-8 py-4 lg:py-6 text-[0.7rem] font-black text-slate-400 uppercase tracking-widest text-right">Enrolled On</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-50">
                <% if (enrollments != null && !enrollments.isEmpty()) {
                    for (Enrollment en : enrollments) { %>
                    <tr class="group hover:bg-slate-50/30 transition-colors">
                        <td class="px-5 sm:px-8 py-5 lg:py-8 font-black text-slate-800 leading-tight">
                            <%= en.getStudentName() %>
                            <div class="text-[0.65rem] text-slate-400 uppercase tracking-widest font-black mt-1">Student</div>
                        </td>
                        <td class="px-5 sm:px-8 py-5 lg:py-8">
                            <div class="text-sm font-bold text-slate-600 truncate max-w-xs"><%= en.getCourseTitle() %></div>
                            <div class="text-[0.65rem] font-black text-brand uppercase tracking-widest mt-1"><%= en.getCategory() %></div>
                        </td>
                        <td class="px-5 sm:px-8 py-5 lg:py-8">
                            <div class="flex flex-col items-center gap-2">
                                <div class="w-24 sm:w-32 h-2 rounded-full bg-slate-100 overflow-hidden ring-4 ring-slate-50">
                                    <div class="js-progress-fill h-full rounded-full transition-all duration-700 <%= en.getProgress() >= 100 ? "bg-amber-400" : "bg-brand" %>" data-progress="<%= en.getProgress() %>"></div>
                                </div>
                                <span class="text-[0.65rem] font-black text-slate-400 tabular-nums"><%= en.getProgress() %>% complete</span>
                            </div>
                        </td>
                        <td class="px-5 sm:px-8 py-5 lg:py-8 text-center">
                            <span class="inline-flex px-3 sm:px-4 py-1.5 rounded-full text-[0.6rem] font-black uppercase tracking-widest
                                <%= "active".equals(en.getStatus()) ? "bg-brand/10 text-brand" : "completed".equals(en.getStatus()) ? "bg-amber-50 text-amber-600" : "bg-red-50 text-red-600" %>">
                                <%= en.getStatus() %>
                            </span>
                        </td>
                        <td class="px-5 sm:px-8 py-5 lg:py-8 text-right text-xs font-black text-slate-400 tabular-nums">
                            <%= en.getEnrolledAt() %>
                        </td>
                    </tr>
                <% } } else { %>
                    <tr><td colspan="5" class="px-5 sm:px-8 py-20 lg:py-32 text-center">
                        <div class="w-20 h-20 lg:w-24 lg:h-24 bg-slate-50 rounded-3xl lg:rounded-[2.5rem] flex items-center justify-center mx-auto mb-6 lg:mb-8 text-slate-100">
                            <svg class="w-10 h-10 lg:w-12 lg:h-12" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/></svg>
                        </div>
                        <p class="text-base font-black text-slate-400 uppercase tracking-widest">No enrollments yet</p>
                    </td></tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/pages/common/footer.jsp" %>
