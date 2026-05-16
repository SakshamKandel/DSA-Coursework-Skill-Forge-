        </div>
    </main>
</div>
<script>
    // Apply progress bar widths from data-progress to keep JSP markup free of inline styles
    document.addEventListener('DOMContentLoaded', function () {
        document.querySelectorAll('.js-progress-fill[data-progress]').forEach(function (el) {
            var p = parseInt(el.getAttribute('data-progress'), 10);
            if (isNaN(p)) p = 0;
            if (p < 0) p = 0;
            if (p > 100) p = 100;
            el.style.width = p + '%';
        });
    });
</script>
</body>
</html>
