command: "ps axro \"%cpu,ucomm,pid\" | awk 'FNR>1' | tail +1 | head -n 5 | sed -e 's/^[ ]*\\([0-9][0-9]*\\.[0-9][0-9]*\\)\\ /\\1\\%\\,/g' -e 's/\\ \\ *\\([0-9][0-9]*$\\)/\\,\\1/g'"

refreshFrequency: '2s'

style: """
  // Change bar height
  bar-height = 6px

  // Align contents left or right
  widget-align = left

  // Position this where you want
  top 250px
  left 10px

  // Statistics text settings
  color #fff
  font-family Helvetica Neue
  background rgba(#000, .5)
  padding 10px 10px 5px
  border-radius 5px

  .container
    width: 300px
    text-align: widget-align
    position: relative
    clear: both

  .widget-title
    text-align: widget-align
    font-size 10px
    text-transform uppercase
    font-weight bold

  .stats-container
    margin-bottom 5px
    border-collapse collapse

  td
    font-size: 14px
    font-weight: 300
    color: rgba(#fff, .9)
    text-shadow: 0 1px 0px rgba(#000, .7)
    text-align: widget-align
    position: relative

  .label
    float: left
    width: 250px
    text-overflow: ellipsis

  .percentage
    float: right

  sup
    position: relative
    font-size: 8px
    top: 1px

"""


render: -> """
  <div class="container">
    <div class="widget-title">Processes</div>
    <table class="stats-container" width="100%">
      <tr>
        <td class='col1'></td>
      </tr>
      <tr>
        <td class='col2'></td>
      </tr>
      <tr>
        <td class='col3'></td>
      </tr>
      <tr>
        <td class='col4'></td>
      </tr>
      <tr>
        <td class='col5'></td>
      </tr>
    </table>
  </div>
"""

update: (output, domEl) ->
  processes = output.split('\n')
  table     = $(domEl).find('table')

  renderProcess = (cpu, name, id) ->
    "<div class='wrapper'>" +
      "<div class='label'>#{name} <sup>(#{id})</sup></div><div class='percentage'>#{cpu}</div>" +
    "</div>"

  for process, i in processes
    args = process.split(',')
    if args[1] != 'top'
      table.find(".col#{i+1}").html renderProcess(args...)
