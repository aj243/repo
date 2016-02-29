ready = ->

	$('#users').dataTable()

	changeUserRole = ()->
		$('.user-role').on 'change', ()->
			select_id = $(this).attr('id')
			role = $(this).val()
			user_id = select_id.split('_').reverse()[0]
			url = "/users/#{user_id}/change_user_role"

			$.ajax
				url: url
				type: 'PUT'
				data: { user: { role: role } }
				success: ()->
					alert('Updated')

	changeUserRole()



		



$(document).ready(ready)
$(document).on('page:load', ready)
  	