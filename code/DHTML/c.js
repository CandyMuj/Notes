var config = {
    imgPrefix: ''
}

/**
 * 核心方法
 */
var C = {
    /** demoId: demo-001
     * 
     * 限制输入框输入的内容仅可是 [正数] 并可自定义保留的小数位数
     * - 自动替换非数字，或不符合小数位数的字符
     * 
     * @param {一般为this} dom js对象
     * @param {需要保留的小数位数} n 为空：默认两位 \n 为0 或小于0：正整数
     */
    onlyNum: function (dom, n) {
        n = (n == 0 || n) ? n : 2;
        var reg = new RegExp("\\d+(" + (n > 0 ? "\\.\\d{0," + n + "}" : "") + ")?");
        dom.value = dom.value.match(reg) ? dom.value.match(reg)[0] : '';
    },

    /** demoId: demo-002
     * 
     * 动态生成一个带有预设样式的 img 标签
     * 其中的 onclick 事件可以自己定义实现的功能，根据不同的框架可能方法有所不同（如：点击打开一个窗口查看大图）
     * 
     * @param {*} uri 
     * @param {*} styleType 
     */
    imghtml: function (uri, styleType) {
        var style;
        switch (styleType) {
            case enumc.imghtmlStyleType.round:
                style = 'width:60px;height:60px;border-radius:60px;';
                break;
            default:
                style = '';
                break;
        }

        return '<img onclick="" src=' + config.imgPrefix + uri + ' class="layui-upload-img" style="' + style + '">';
    },
}


/**
 * 一些枚举值定义
 */
var enumc = {
    imghtmlStyleType: {
        // 一个圆角图片 img 样式 标签
        round: 1
    }

}