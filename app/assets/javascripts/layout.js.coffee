$(".icon-reorder").click (e) ->
  if $(e.target).hasClass("collapsed")
    $(".dashboard-sidebar").animate width: 241, 110
    $(".page-wrapper").animate paddingLeft: 240, 110
    $(".sidebar-label").delay(200).animate opacity: 100, 20
    $(e.target).removeClass("collapsed")
  else
    $(".sidebar-label").animate opacity: 0, 20
    $(".dashboard-sidebar").animate width: 60, 110
    $(".page-wrapper").animate paddingLeft: 60, 110
    $(e.target).addClass("collapsed")
