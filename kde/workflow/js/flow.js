var flow = {
  
  $container: null,
  $toolsContainer: null,
  state: {
    multi: null
  },
  
  initialize: function () {
    this.setAttributes();
    this.initEvents();
    this.initCustomEvents();
  },
  setAttributes: function () {
    this.$container = $('.GooFlow');
    this.$toolsContainer = $('.GooFlow_tool');
  },
  initEvents: function () {
    this.$toolsContainer.on('mouseup', '.GooFlow_tool_btn', $.proxy(function (e) {
      var $target = $(e.currentTarget);
      if ($target.attr('id') == 'Flow_btn_multi') {
        if (!this.state.multi) {
          this.state.multi = true;
          this.$container.trigger('stateChanged', this.state);
        }
      } else if ($target.attr('id') == 'Flow_btn_top') {
        this.alignTop();
        setTimeout($.proxy(function () {
          this.$container.find('#Flow_btn_multi').click();
        }, this), 20);
      } else if ($target.attr('id') == 'Flow_btn_left') {
        this.alignLeft();
        setTimeout($.proxy(function () {
          this.$container.find('#Flow_btn_multi').click();
        }, this), 20);
      } else {
        if (this.state.multi) {
          this.state.multi = false;
          this.$container.trigger('stateChanged', this.state);
        }
      }
    }, this));
  },
  initCustomEvents: function () {
    this.$container.on('stateChanged', $.proxy(function (e, state) {
      if (!state.multi) {
        this.$container.find('.GooFlow_item').each(function () {
          if (!$(this).find('.rs_close').parent().is(':visible')) {
            $(this).removeClass('item_focus');
          }
        });
      }
    }, this));
  },
  toggleItem: function (e) {
    var $target = $(e.currentTarget).closest('.GooFlow_item');
    $target.toggleClass('item_focus');
  },
  alignTop: function () {
    var $targets = this.$container.find('.item_focus');
    var top = this.getTop($targets);
    $targets.each(function () {
      var left = parseFloat($(this).css('left'), 10);
      Flow.moveNode(this.id, left, top);
    });
  },
  alignLeft: function () {
    var $targets = this.$container.find('.item_focus');
    var left = this.getLeft($targets);
    $targets.each(function () {
      var top = parseFloat($(this).css('top'), 10);
      Flow.moveNode(this.id, left, top);
    });
  },
  getTop: function ($targets) {
    var top = Infinity;
    $targets.each(function () {
      var current = parseFloat($(this).css('top'), 10);
      if (current && current < top) {
        top = current;
      }
    });
    return top;
  },
  getLeft: function ($targets) {
    var left = Infinity;
    $targets.each(function () {
      var current = parseFloat($(this).css('left'), 10);
      if (current && current < left) {
        left = current;
      }
    });
    return left;
  }
}