class Postgres::UserEvent::Create
  def call(row_attrs:)
    user_event = UserEvent.create!(user_id: row_attrs[:event_id], event_id: row_attrs[:user_id])

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
        errors: resource.errors
      }
    end
  end
end