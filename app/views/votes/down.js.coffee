$(".arrows#<%= @votable_instance.selector %>").replaceWith('<%= j render partial: "votes/voter", locals: {votable: @votable_instance} %>')
