class Postgres::UserEvent::Create
  def call(row_attrs:)
    user_event = UserEvent.create(user_id: row_attrs[:user_id], event_id: row_attrs[:event_id])

    if user_event.persisted?
      {
        success: true,
        data: {
          id: user_event.id
        }
      }
    else
      {
        success: false,
        errors: user_event.errors
      }
    end
  end
end