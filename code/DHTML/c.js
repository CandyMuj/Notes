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
}