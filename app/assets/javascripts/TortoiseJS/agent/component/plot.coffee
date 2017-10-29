window.RactivePlot = RactiveWidget.extend({

  data: -> {
    contextMenuOptions: [@standardOptions(this).deleteAndRecompile]
  }

  template:
    """
    <div id="{{id}}"
         on-contextmenu="@this.fire('showContextMenu', @event)"
         draggable="true" on-drag="dragWidget" on-dragstart="startWidgetDrag" on-dragend="stopWidgetDrag"
         class="netlogo-widget netlogo-plot"
         style="{{dims}} {{ #isEditing }}padding: 10px;{{/}}"></div>
    """

})
