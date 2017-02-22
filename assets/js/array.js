/****************************************************
*CreateBy:joe zhou
*Description:数组统计函数
****************************************************/
$.extend({
    max: function (arr) {
        return cacl(arr, function (item, max) {
            if (!(max > item)) {
                return item;
            }
            else {
                return max;
            }
        });
    },
    min: function (arr) {
        return cacl(arr, function (item, min) {
            if (!(min < item)) {
                return item;
            }
            else {
                return min;
            }
        });
    },
    sum: function (arr) {
        return cacl(arr, function (item, sum) {
            if (typeof (sum) == 'undefined') {
                return item;
            }
            else {
                return sum += item;
            }
        });
    },
    avg: function (arr) {
        if (typeof (arr) == 'undefined' || arr.length == 0) {
            return 0;
        }
        return this.sum(arr) / arr.length;
    }
});

$.fn.extend({
    max: function () {
        return $.max(this.get());
    },
    min: function () {
        return $.min(this.get());
    },
    sum: function () {
        return $.sum(this.get());
    },
    avg: function () {
        return $.avg(this.get());
    }
});

function cacl(arr, callback) {
    var ret;
    for (var i=0; i<arr.length;i++) {
        ret = callback(arr[i], ret);
    }
    return ret;
}

Array.prototype.max = function () {
    return cacl(this, function (item, max) {
        if (!(max > item)) {
            return item;
        }
        else {
            return max;
        }
    });
};
Array.prototype.min = function () {
    return cacl(this, function (item, min) {
        if (!(min < item)) {
            return item;
        }
        else {
            return min;
        }
    });
};
Array.prototype.sum = function () {
    return cacl(this, function (item, sum) {
        if (typeof (sum) == 'undefined') {
            return item;
        }
        else {
            return sum += item;
        }
    });
};
Array.prototype.avg = function () {
    if (this.length == 0) {
        return 0;
    }
    return this.sum(this) / this.length;
};