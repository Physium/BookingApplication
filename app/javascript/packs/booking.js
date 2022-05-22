import '@rails/ujs'
import 'tempusdominus-bootstrap-4'

$(function () {
  $('#datetimepicker1').datetimepicker({
    format: 'MMMM D, YYYY h:mm A',
    stepping: 10,
    locale: 'en',
    minDate: Date(),
    maxDate: new Date(Date.now() + (365 * 24 * 60 * 60 * 1000)),
    sideBySide: true
  });

  $('#datetimepicker1').on('change.datetimepicker', ({date, oldDate}) => {
    console.log(date)
    console.log(oldDate)

    var enddate = $('#datetimepicker2').datetimepicker('date')
    if (enddate == null) {
      $('#datetimepicker2').datetimepicker('date',new Date(date + (60 * 60 * 1000)));
    }
    console.log(enddate)
  })

  $('#datetimepicker2').on('change.datetimepicker',({date, oldDate}) => {
    console.log(date.format())
    var starttime = $('#datetimepicker1').datetimepicker('date').format()

    $.post("/bookings/search", {"start_time": starttime, "end_time": date.format()}).done(function(data){
      console.log(data)
      $('#booking_room_id').empty()
      for(var i in data) {
        var id = data[i].id
        var title = data[i].name
        var capacity = data[i].capacity
        var option = title + "( Capacity: "+capacity+")"
        $('#booking_room_id').append(new Option(option, id))
      }
    })
  })

  $('#datetimepicker2').datetimepicker({
    currentDate: false,
    format: 'MMMM D, YYYY h:mm A',
    stepping: 10,
    locale: 'en',
    minDate: Date(),
    maxDate: new Date(Date.now() + (365 * 24 * 60 * 60 * 1000)),
    sideBySide: true
  });
});

$.fn.datetimepicker.Constructor.Default = $.extend({},
  $.fn.datetimepicker.Constructor.Default,
  { icons:
      { time: 'fas fa-clock',
        date: 'fas fa-calendar',
        up: 'fas fa-arrow-up',
        down: 'fas fa-arrow-down',
        previous: 'fas fa-arrow-circle-left',
        next: 'fas fa-arrow-circle-right',
        today: 'far fa-calendar-check-o',
        clear: 'fas fa-trash',
        close: 'far fa-times' } });