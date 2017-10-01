/**
 * 分页函数
 * @param paginationId 分页Id
 * @param totalPages 总页数
 * @param callback 回掉函数
 */
function initPagination (paginationId, totalPages, callback) {
    var options = {
        bootstrapMajorVersion: 3,
        currentPage: 1,
        numberOfPages: 5,
        size:'large',
        totalPages: totalPages,
        itemTexts: function (type, page, current) {
            switch (type) {
                case "first":
                    return "First";
                case "prev":
                    return "Previous";
                case "next":
                    return "Next";
                case "last":
                    return "Last";
                case "page":
                    return page;
            }
        },
        onPageClicked: function(e, originalEvent, type, page){
            callback(page);
            $('body, html').animate({scrollTop:0}, 100);
        }
    };
    $('#' + paginationId).bootstrapPaginator(options);
}