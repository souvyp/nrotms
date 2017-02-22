// 判断日期是否有效
function isValidDate(value, userFormat) {

  // Set default format if format is not provided
  //如果没有提供格式设置默认格式
  userFormat = userFormat || 'mm/dd/yyyy';

  // Find custom delimiter by excluding
  // month, day and year characters
  //找到自定义分隔符不
  //月，日和年的字符
  var delimiter = /[^mdy]/.exec(userFormat)[0];

  // Create an array with month, day and year
  // so we know the format order by index
  //创建一个数组，一个月，一天和一年
  //所以我们知道的格式顺序索引
  var theFormat = userFormat.split(delimiter);

  // Create array from user date
  //从用户日期创建数组
  var theDate = value.split(delimiter);

  function isDate(date, format) {
    var m, d, y, i = 0, len = format.length, f;
    for (i; i < len; i++) {
      f = format[i];
      if (/m/.test(f)) m = date[i];
      if (/d/.test(f)) d = date[i];
      if (/y/.test(f)) y = date[i];
    }
    return (
      m > 0 && m < 13 &&
      y && y.length === 4 &&
      d > 0 &&
      // Check if it's a valid day of the month
      // 检查，如果这是一个月有效的一天
      d <= (new Date(y, m, 0)).getDate()
    );
  }

  return isDate(theDate, theFormat);
}
//使用方法：
//
//下面这个调用返回false，因为11月份没有31天

//isValidDate('dd-mm-yyyy', '31/11/2012')

/*******************************************************************************/

//获取一组元素的最大宽度或高度
//下面这个函数，对于需要进行动态排版的开发人员非常有用。

var getMaxHeight = function ($elms) {
  var maxHeight = 0;
  $elms.each(function () {
    // In some cases you may want to use outerHeight() instead
    //在某些情况下，您可能希望使用outerheight()相反
    var height = $(this).height();
    if (height > maxHeight) {
      maxHeight = height;
    }
  });
  return maxHeight;
};
//使用方法：

//$(elements).height( getMaxHeight($(elements)) );

/*******************************************************************************/

//高亮文本


function highlight(text, words, tag) {

  // Default tag if no tag is provided
    //如果没有标记，则默认标记
  tag = tag || 'span';

  var i, len = words.length, re;
  for (i = 0; i < len; i++) {
    // Global regex to highlight all matches
    //全局正则表达式来突出所有
    re = new RegExp(words[i], 'g');
    if (re.test(text)) {
      text = text.replace(re, '<'+ tag +'>$&</'+ tag +'>');
       //设置高亮的效果  在 regexp  里面  随意些css   字体颜色为红色
//eg：         text = text.replace(re, '<'+ tag +' style="color:red"; >$&</'+ tag +'>');      
    }
  }

  return text;
}


function unhighlight(text, tag) {  
 
  // Default tag if no tag is provided
  //如果没有标记，则默认标记
  tag = tag || 'span';
  var re = new RegExp('(<'+ tag +'.+?>|<\/'+ tag +'>)', 'g');
  return text.replace(re, '');
}
//高亮文本

//使用方法：
$('p').html( highlight(
    $('p').html(), // the text
    ['foo', 'bar', 'baz', 'hello world'], 
    //单词或短语的列表来突出
    // list of words or phrases to highlight
    'strong' // custom tag
							//自定义标签
));