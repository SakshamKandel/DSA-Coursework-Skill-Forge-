<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.skillforge.model.ContactMessage, java.util.List" %>
<%
    request.setAttribute("pageTitle", "Contact Messages");
    request.setAttribute("activePage", "messages");
%>
<%@ include file="/WEB-INF/pages/common/header.jsp" %>
<%
    List<ContactMessage> messages = (List<ContactMessage>) request.getAttribute("messages");
    int pending = 0;
    if (messages != null) {
        for (ContactMessage m : messages) if (!m.isHandled()) pending++;
    }
%>

<!-- Page content -->
<div class="p-10 space-y-8">

    <!-- Page header -->
    <div class="flex items-center justify-between mb-4">
        <div>
            <h2 class="text-3xl font-black text-slate-800 tracking-tight">Contact Messages</h2>
            <p class="text-[0.7rem] font-black text-slate-400 uppercase tracking-widest mt-2">Inquiries submitted through the Contact page</p>
        </div>
        <div class="flex gap-4">
            <div class="px-6 py-4 rounded-2xl bg-white shadow-sm ring-1 ring-slate-100 flex items-center gap-3">
                <span class="text-[0.7rem] font-black text-slate-400 uppercase tracking-widest border-r border-slate-100 pr-3">Pending</span>
                <span class="text-sm font-black text-slate-800"><%= pending %></span>
            </div>
            <div class="px-6 py-4 rounded-2xl bg-white shadow-sm ring-1 ring-slate-100 flex items-center gap-3">
                <span class="text-[0.7rem] font-black text-slate-400 uppercase tracking-widest border-r border-slate-100 pr-3">Total</span>
                <span class="text-sm font-black text-slate-800"><%= messages != null ? messages.size() : 0 %></span>
            </div>
        </div>
    </div>

    <% if (messages == null || messages.isEmpty()) { %>
        <div class="bg-white rounded-[2.5rem] p-20 text-center shadow-[0_8px_30px_rgb(0,0,0,0.04)] ring-1 ring-slate-100">
            <div class="w-24 h-24 bg-slate-50 rounded-[2.5rem] flex items-center justify-center mx-auto mb-6 text-slate-200">
                <svg class="w-12 h-12" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                    <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/>
                    <polyline points="22,6 12,13 2,6"/>
                </svg>
            </div>
            <p class="text-base font-black text-slate-400 uppercase tracking-widest">No messages yet</p>
            <p class="text-sm font-bold text-slate-300 mt-2">Inquiries sent through the Contact page will appear here.</p>
        </div>
    <% } else { %>
        <div class="space-y-5">
            <% for (ContactMessage m : messages) { %>
                <div class="bg-white rounded-[2rem] p-8 shadow-[0_8px_30px_rgb(0,0,0,0.04)] ring-1 ring-slate-100 <%= m.isHandled() ? "opacity-70" : "" %>">

                    <!-- Top row: sender info plus status badge -->
                    <div class="flex flex-col md:flex-row md:items-start md:justify-between gap-4 mb-4">
                        <div>
                            <div class="flex items-center gap-3 mb-2">
                                <h3 class="text-lg font-black text-slate-800"><%= m.getFullName() %></h3>
                                <% if (m.isHandled()) { %>
                                    <span class="inline-flex px-3 py-1 rounded-full text-[0.6rem] font-black uppercase tracking-widest bg-slate-100 text-slate-500">Handled</span>
                                <% } else { %>
                                    <span class="inline-flex px-3 py-1 rounded-full text-[0.6rem] font-black uppercase tracking-widest bg-amber-50 text-amber-600">New</span>
                                <% } %>
                            </div>
                            <div class="flex flex-wrap items-center gap-4 text-xs font-bold text-slate-500">
                                <a href="mailto:<%= m.getEmail() %>" class="hover:text-brand transition-colors">
                                    <%= m.getEmail() %>
                                </a>
                                <span class="w-1 h-1 rounded-full bg-slate-200"></span>
                                <span class="text-slate-400"><%= m.getSentAt() %></span>
                            </div>
                        </div>

                        <% if (!m.isHandled()) { %>
                            <a href="<%= ctx %>/admin/messages?action=handle&id=<%= m.getId() %>"
                               class="inline-flex items-center gap-2 px-5 py-3 rounded-2xl bg-brand/10 text-brand font-black text-xs uppercase tracking-widest hover:bg-brand hover:text-white transition-all">
                                Mark as handled
                            </a>
                        <% } %>
                    </div>

                    <!-- Subject -->
                    <div class="text-sm font-black text-slate-700 uppercase tracking-widest mb-3"><%= m.getSubject() %></div>

                    <!-- Body of the message -->
                    <div class="p-5 bg-slate-50 rounded-2xl text-sm font-bold text-slate-600 leading-relaxed whitespace-pre-wrap"><%= m.getMessage() %></div>
                </div>
            <% } %>
        </div>
    <% } %>

</div>

<%@ include file="/WEB-INF/pages/common/footer.jsp" %>
