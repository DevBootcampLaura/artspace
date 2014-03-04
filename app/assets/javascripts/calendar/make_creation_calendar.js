function make_creation_calendar(events_input) {
  var calendar = {
    scrollToHourMillis : 0,
    timeslotsPerHour: 2,
    timeslotHeight: 20,
    defaultFreeBusy: {free: true},
    displayFreeBusys: false,
    buttons: false,
    displayOddEven: true,
    allowEventDelete: true,
    daysToShow: 7,
    headerSeparator: ' ',
    useShortDayNames: false,
    allowCalEventOverlap: false,
    dateFormat: 'd F y',
    businessHours: false,

    height: function($calendar){
      return $(window).height() - $('h1').outerHeight(true);
    },

    title: function() {
      return "Mark the weekly business hours for your space on the calendar below";
    },

    eventRender : function(calEvent, $event) {
      if (calEvent.end.getTime() < new Date().getTime()) {
        $event.find('.wc-time').css({
          backgroundColor: '#999',
          border:'1px solid #888'
        });
      }
    },

    eventDelete: function(calEvent, element, dayFreeBusyManager, calendar, clickEvent) {
      if (confirm('You want to delete this reservation?')) {
        removeEvent(calEvent, calendar);
      }
    },

    data: function(start, end, callback) {
      callback(events_input);
    },

    getHeaderDate: function(date, calendar) {
      return get_day(date);
    },


    eventBody: function() {
      return "Available hours";
    },

  }

  return calendar;

}
