/**

 @Name: jadmin主入口

 */


layui.define(['layer', 'laytpl', 'form', 'upload', 'util'], function (exports) {

    var $ = layui.jquery
        , layer = layui.layer
        , laytpl = layui.laytpl
        , form = layui.form()
        , util = layui.util
        , device = layui.device()

    //阻止IE7以下访问
    if (device.ie && device.ie < 8) {
        layer.alert('如果您非得使用ie浏览jadmin，那么请使用ie8+');
    }

    layui.focusInsert = function (obj, str) {
        var result, val = obj.value;
        obj.focus();
        if (document.selection) { //ie
            result = document.selection.createRange();
            document.selection.empty();
            result.text = str;
        } else {
            result = [val.substring(0, obj.selectionStart), str, val.substr(obj.selectionEnd)];
            obj.focus();
            obj.value = result.join('');
        }
    };

    var gather = {

        //Ajax
        json: function (url, data, success, options) {
            var that = this;
            options = options || {};
            data = data || {};
            return $.ajax({
                type: options.type || 'post',
                dataType: options.dataType || 'json',
                data: data,
                url: url,
                success: function (res) {
                    if (res.status === 0) {
                        success && success(res);
                    } else {
                        layer.msg(res.msg || res.code, {shift: 6});
                    }
                }, error: function (e) {
                    options.error || layer.msg('请求异常，请重试', {shift: 6});
                }
            });
        }
        , form: {}

    };


    //表单提交
    form.on('submit(*)', function (data) {
        // 登录写在这里了
        var action = $(data.form).attr('action'), button = $(data.elem);
        var pwd = $('[name="password"]').val();
        $('[name="password"]').val(hex_md5(pwd));
        form1.submit();
        return;
        /*    gather.json(action, data.field, function(res){
         var end = function(){
         if(res.action){
         location.href = res.action;
         } else {
         gather.form[action||button.attr('key')](data.field, data.form);
         }
         };
         if(res.status == 0){
         button.attr('alert') ? layer.alert(res.msg, {
         icon: 1,
         time: 10*1000,
         end: end
         }) : end();
         };
         });*/
    });

    //加载特定模块
    if (layui.cache.page && layui.cache.page !== 'index') {
        var extend = {};
        extend[layui.cache.page] = layui.cache.page;
        layui.extend(extend);
        layui.use(layui.cache.page);
    }


     //右下角固定Bar
     util.fixbar({
     bar1: false // true
     ,click: function(type){
     if(type === 'bar1'){
     layer.msg('bar1');
     }
     }
     });


    //手机设备的简单适配
    var treeMobile = $('.site-tree-mobile')
        , shadeMobile = $('.site-mobile-shade')

    treeMobile.on('click', function () {
        $('body').addClass('site-mobile');
    });

    shadeMobile.on('click', function () {
        $('body').removeClass('site-mobile');
    });

    exports('fly', gather);

});

