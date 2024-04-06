unless Rails.env.production?
  namespace :dev do
    desc "Drops, creates, migrates, and adds sample data to database"

    start_time = Time.now
    task reset: [
      :environment,
      "db:drop",
      "db:create",
      "db:migrate",
      "dev:sample_data",
    ]

    desc "Add sample data for development environment"
    task sample_data: [
      "dev:add_users",
      "dev:add_boards",
      "dev:add_job_listings",
      "dev:add_interviews",
    ] do
      puts "done adding sample data"
      end_time = Time.now
      puts "It took #{(end_time - start_time).to_i} seconds to create sample data."
    end

    task add_users: :environment do
      puts "adding users..."
      people = Array.new(3) do
        {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
        }
      end

      User.create!(
        email: "andrew@example.com",
        password: "pass123",
        role: :admin,
        username: "andrew",
        first_name: "andrew",
        last_name: "pham",
      )
      User.create!(
        email: "bob@example.com",
        password: "123456",
        role: :moderator,
        username: "bob",
        first_name: "bob",
        last_name: "bobby",
      )


      6.times do
        first_name = Faker::Name.first_name
        last_name = Faker::Name.last_name
        username = first_name.downcase

        user = User.create(
          email: "#{username}@example.com",
          password: "password",
          username: username,
          first_name: first_name,
          last_name: last_name,
          role: :user,
        )
      end
      puts "There are now #{User.count} users"
    end

    task add_boards: :environment do
      puts "adding boards..."
      3.times do |i|
        board = Board.create(
          board_name: "Job board ##{Time.now.year - i}",
          user_id: User.all.sample.id
        )
      end

      puts "There are now #{Board.count} boards"
    end

    task add_job_listings: :environment do
      puts "adding job listings..."
      400.times do |job|
        rand_salary = rand(40000.0..110000.0)
        status = [:pending, :under_review, :interviewing, :rejected].sample
        job = JobListing.create(
          board_id: Board.all.sample.id,
          title: Faker::Job.title,
          company: Faker::Company.name,
          location: "#{Faker::Address.city}, #{Faker::Address.state_abbr}",
          salary: sprintf("%.2f", rand_salary).to_f,
          job_url: Faker::Internet.url,
          portal_url: Faker::Internet.url(host: "example.com"),
          status: status,
          details: Faker::Lorem.paragraph(sentence_count: 10),
          details_summary: Faker::ProgrammingLanguage.name,
          total_points: rand(-1..6),
          created_at: Time.now - rand(1..212).days
        )
      end
      puts "There are now #{JobListing.count} job listings"
    end

    task add_interviews: :environment do
      puts "adding interviews"
      60.times do |interview|
        interview_type = [
          "Phone Interview",
          "On-site Interview",
          "Video Interview",
          "Technical Interview",
          "Behavioral Interview",
          "Panel Interview",
        ].sample
        start_date = Time.now + rand(1..15).days
        end_date = start_date.advance(days: rand(10..20))
        interview = Interview.create(
          interview_type: interview_type,
          details: Faker::Lorem.paragraph(sentence_count: 1),
          start_date: start_date,
          end_date: end_date,
          job_listing_id: JobListing.all.sample.id,
          point: 1,
        )
      end
      puts "There are now #{Interview.count} interviews"
    end
  end
end
