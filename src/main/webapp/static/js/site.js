(function () {
    function renderPortalChart() {
        var box = document.getElementById('portalTrendChart');
        if (!box || !window.echarts || !window.portalStats) {
            return;
        }
        var chart = echarts.init(box);
        chart.setOption({
            color: ['#1f7a43', '#45b56c'],
            tooltip: { trigger: 'axis' },
            grid: { left: 20, right: 20, top: 30, bottom: 20, containLabel: true },
            xAxis: {
                type: 'category',
                data: ['公开周期', '在售产品', '认证农户', '累计订单'],
                axisLine: { lineStyle: { color: '#d8e7dd' } },
                axisLabel: { color: '#607168' }
            },
            yAxis: {
                type: 'value',
                axisLine: { show: false },
                splitLine: { lineStyle: { color: '#eef3f0' } },
                axisLabel: { color: '#607168' }
            },
            series: [{
                type: 'bar',
                barWidth: 24,
                data: [
                    window.portalStats.publicCycleCount,
                    window.portalStats.productCount,
                    window.portalStats.farmerCount,
                    window.portalStats.orderCount
                ],
                itemStyle: { borderRadius: [10, 10, 0, 0] }
            }]
        });
        window.addEventListener('resize', function () {
            chart.resize();
        });
    }

    function renderDashboardChart() {
        var id = window.dashboardMode === 'admin' ? 'adminChart' : 'sellerChart';
        var box = document.getElementById(id);
        if (!box || !window.echarts || !window.dashboardStats) {
            return;
        }
        var chart = echarts.init(box);
        chart.setOption({
            color: ['#1f7a43', '#62c483', '#a8d9b8'],
            tooltip: { trigger: 'item' },
            legend: { bottom: 0 },
            series: [{
                type: 'pie',
                radius: ['48%', '72%'],
                avoidLabelOverlap: false,
                label: { formatter: '{b}\n{c}' },
                data: [
                    { value: window.dashboardStats.cycleCount, name: '周期数量' },
                    { value: window.dashboardStats.productCount, name: '产品数量' },
                    { value: window.dashboardStats.orderCount, name: '订单数量' }
                ]
            }]
        });
        window.addEventListener('resize', function () {
            chart.resize();
        });
    }

    function togglePreview($preview, $empty, url) {
        if (!$preview.length) {
            return;
        }
        if (url) {
            $preview.attr('src', url).removeClass('d-none').show();
            if ($empty && $empty.length) {
                $empty.addClass('d-none');
            }
        } else {
            $preview.attr('src', '').addClass('d-none');
            if ($empty && $empty.length) {
                $empty.removeClass('d-none');
            }
        }
    }

    function syncImageGroup($input, value) {
        var syncGroup = $input.data('sync-group');
        if (!syncGroup) {
            return;
        }
        $('[data-sync-group="' + syncGroup + '"]').not($input).val(value);
    }

    function updateRegisterAvatarPreview(url) {
        togglePreview($('#registerAvatarPreview'), $('#registerAvatarEmpty'), url);
    }

    function syncCartSummary(res) {
        $('.js-cart-total-value').text('¥' + formatMoney(res.cartTotal));
        $('.js-cart-size-value').text(res.cartSize + ' 件');
        $('.js-cart-size-label').text('已加入 ' + res.cartSize + ' 件商品');
    }

    function bindCartUpdate($form) {
        var pending = $form.data('pending');
        if (pending) {
            return;
        }
        $form.data('pending', true);
        var $button = $form.find('.js-cart-update-btn');
        $button.prop('disabled', true).text('更新中...');
        $.ajax({
            url: $form.attr('action'),
            type: 'POST',
            data: $form.serialize(),
            success: function (res) {
                if (!res || !res.success) {
                    alert((res && res.message) || '更新失败');
                    return;
                }
                var $card = $form.closest('.js-cart-card');
                $form.find('.js-qty-input').val(res.quantity);
                $card.find('.js-cart-subtotal-value').text('¥' + formatMoney(res.subtotal));
                syncCartSummary(res);
            },
            error: function () {
                alert('更新失败，请稍后重试');
            },
            complete: function () {
                $form.data('pending', false);
                $button.prop('disabled', false).text('更新数量');
            }
        });
    }

    $(function () {
        renderPortalChart();
        renderDashboardChart();

        $('.custom-file-input').on('change', function () {
            var fileName = '';
            if (this.files && this.files.length > 0) {
                fileName = this.files[0].name;
            }
            $(this).next('.custom-file-label').text(fileName || '选择图片文件');
        });

        $('#registerAvatarFile').on('change', function () {
            if (!this.files || !this.files.length) {
                return;
            }
            var file = this.files[0];
            if (!file.type || file.type.indexOf('image/') !== 0) {
                return;
            }
            if (window.URL && window.URL.createObjectURL) {
                updateRegisterAvatarPreview(window.URL.createObjectURL(file));
            }
        });

        $('#registerAvatarPreview').on('error', function () {
            var hiddenValue = $.trim($('#registerAvatar').val());
            if (hiddenValue && this.src !== hiddenValue) {
                updateRegisterAvatarPreview(hiddenValue);
                return;
            }
            updateRegisterAvatarPreview('');
        });

        $('#registerAvatar').on('input change', function () {
            updateRegisterAvatarPreview($.trim($(this).val()));
        });

        $('.js-image-url-input').on('input change', function () {
            var target = $(this).data('preview');
            var $preview = target ? $(target) : $();
            var $empty = $($(this).data('empty') || '');
            var value = $.trim($(this).val());
            togglePreview($preview, $empty, value);
            syncImageGroup($(this), value);
        });

        $(document).on('click', '.js-qty-dec', function (e) {
            e.preventDefault();
            var $input = $(this).closest('.qty-stepper').find('.js-qty-input');
            if (!$input.length) {
                return;
            }
            var min = parseInt($input.attr('min') || '1', 10);
            var value = parseInt($input.val() || min, 10);
            value = isNaN(value) ? min : value - 1;
            if (value < min) {
                value = min;
            }
            $input.val(value).trigger('change');
            var $form = $(this).closest('.js-cart-update-form');
            if ($form.length) {
                bindCartUpdate($form);
            }
        });

        $(document).on('click', '.js-qty-inc', function (e) {
            e.preventDefault();
            var $input = $(this).closest('.qty-stepper').find('.js-qty-input');
            if (!$input.length) {
                return;
            }
            var min = parseInt($input.attr('min') || '1', 10);
            var max = parseInt($input.attr('max') || '999999', 10);
            var value = parseInt($input.val() || min, 10);
            value = isNaN(value) ? min : value + 1;
            if (value > max) {
                value = max;
            }
            $input.val(value).trigger('change');
            var $form = $(this).closest('.js-cart-update-form');
            if ($form.length) {
                bindCartUpdate($form);
            }
        });

        $(document).on('change', '.js-qty-input', function () {
            var min = parseInt($(this).attr('min') || '1', 10);
            var max = parseInt($(this).attr('max') || '999999', 10);
            var value = parseInt($(this).val() || min, 10);
            if (isNaN(value) || value < min) {
                value = min;
            }
            if (value > max) {
                value = max;
            }
            $(this).val(value);
        });

        $('.js-cart-update-form').on('submit', function (e) {
            e.preventDefault();
            bindCartUpdate($(this));
        });

        $('.js-cart-delete-btn').on('click', function () {
            var id = $(this).data('id');
            var $card = $(this).closest('.js-cart-card');
            $.ajax({
                url: (window.contextPath || '') + '/user/cart/delete-ajax',
                type: 'POST',
                data: { id: id },
                success: function (res) {
                    if (!res || !res.success) {
                        alert((res && res.message) || '删除失败');
                        return;
                    }
                    $card.slideUp(180, function () {
                        $(this).remove();
                        syncCartSummary(res);
                        if (res.cartSize === 0) {
                            window.location.reload();
                        }
                    });
                },
                error: function () {
                    alert('删除失败，请稍后重试');
                }
            });
        });
    });
})();

function formatMoney(value) {
    var number = parseFloat(value || 0);
    if (isNaN(number)) {
        number = 0;
    }
    return number.toFixed(2);
}

function uploadImage(fileSelector, inputSelector, previewSelector, emptySelector) {
    var $fileInput = $(fileSelector);
    var fileInput = $fileInput[0];
    var $input = $(inputSelector);
    var $preview = previewSelector ? $(previewSelector) : $();
    var $empty = emptySelector ? $(emptySelector) : $();
    var $trigger = $fileInput.closest('.upload-field').find('.js-upload-trigger');
    if (!$trigger.length) {
        $trigger = $fileInput.closest('.farmer-profile-avatar-card, form').find('.js-upload-trigger').first();
    }

    if (!fileInput || !fileInput.files || fileInput.files.length === 0) {
        alert('请先选择图片');
        return false;
    }

    var file = fileInput.files[0];
    var fileName = file.name ? file.name.toLowerCase() : '';
    if (!/\.(jpg|jpeg|png|gif|webp|bmp)$/.test(fileName)) {
        alert('仅支持 jpg、jpeg、png、gif、webp、bmp 格式图片');
        return false;
    }

    if (file.size > 10 * 1024 * 1024) {
        alert('图片大小不能超过 10MB');
        return false;
    }

    if ($preview.length && window.URL && window.URL.createObjectURL) {
        $preview.attr('src', window.URL.createObjectURL(file)).removeClass('d-none').show();
        if ($empty.length) {
            $empty.addClass('d-none');
        }
    }

    var formData = new FormData();
    formData.append('file', file);

    if ($trigger.length) {
        $trigger.prop('disabled', true).text('上传中...');
    }

    $.ajax({
        url: (window.contextPath || '') + '/upload/image',
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function (res) {
            if (res && res.success) {
                $input.val(res.path).trigger('input');
                if ($preview.length) {
                    $preview.attr('src', res.path).removeClass('d-none').show();
                }
                if ($empty.length) {
                    $empty.addClass('d-none');
                }
                alert(res.message || '上传成功');
            } else {
                alert((res && res.message) || '上传失败');
            }
        },
        error: function () {
            alert('上传失败，请稍后重试');
        },
        complete: function () {
            if ($trigger.length) {
                $trigger.prop('disabled', false).text('上传图片');
            }
        }
    });

    return false;
}
