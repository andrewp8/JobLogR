# [JobRecorder](https://www.JobRecorder.com/) 🌐

### Simplify Your Job Application Process

<p align="center" width="100%">
     <img alt="JobRecorder Wireframe" width="700px" src="https://github.com/andrewp8/JobRecorder/assets/69804999/45278cda-7791-40bd-8fe3-8144ea6c7403" />
</p>

## Overview

JobRecorder aims to empower job seekers by providing a comprehensive tool to manage their job applications more efficiently, reducing the stress and disorganization often associated with the job search process.

## How to use JobRecorder

<p align="center">Watch the Video</p>
<p align="center" width="100%">
  <a href="https://www.loom.com/share/6be4b4336cad4b779e56a52a8a244a10">
    <img src="https://cdn.loom.com/sessions/thumbnails/6be4b4336cad4b779e56a52a8a244a10-1713157845766-with-play.gif" alt="How to use JobRecorder gif">
  </a>
</p>

For a comprehensive guide, [see the full interactive version here 👈](https://www.canva.com/design/DAGDLMYiogo/I8uWXvDlHrTUJ45ehY2Pow/view?utm_content=DAGDLMYiogo&utm_campaign=designshare&utm_medium=link&utm_source=publishsharelink).

## Entity-Relationship Diagram (ERD)

Our application's database schema is visualized in the Entity-Relationship Diagram (ERD) below. This diagram provides a clear overview of the tables, their fields, and the relationships between them, facilitating a better understanding of how data is interconnected within our application.

<p align="center" width="100%">
     <img width="987" alt="JobRecorder ERD" src="https://github.com/andrewp8/JobRecorder/assets/69804999/b32f60fe-e586-4980-ac09-65e059141b49">
</p>

## Setup

### Dependencies

- [Active Storage](https://guides.rubyonrails.org/v6.0.0/active_storage_overview.html)
- [AWS SDK for Ruby](https://github.com/aws/aws-sdk-ruby)
- [Omniauth-Google-OAuth2](https://github.com/zquestz/omniauth-google-oauth2)
- [Ruby OpenAI](https://github.com/aFlexrudall/ruby-openai?tab=readme-ov-file#streaming-chat)
- [Chartkick](https://github.com/ankane/chartkick)
- [Action Mailer](https://guides.rubyonrails.org/action_mailer_basics.html)
- [Action Mailbox](https://guides.rubyonrails.org/action_mailbox_basics.html)

### Installation

1. Clone the repository and install dependencies:

   ```bash
   git clone https://github.com/andrewp8/JobRecorder.git
   cd JobRecorder
   bundle install
   rails dev:reset  # Seeds the database with sample data
   rails active_storage:install
   rails db:migrate
   ```

2. **Create a `.env` file:**
   ```bash
   touch .env
   ```
   - Inside the `.env` file, define your credentials using key-value pairs, one per line. Here's the format:
   - `API_KEY=your_secret_api_key`
3. Once you have met the prerequisites, you can start the Rails development server by running the following command in your terminal:

   ```bash
   rails s
   ```

## Contributing

- Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
- **Follow Rails Naming Conventions**: Ensure that all code contributions adhere to the [Rails naming conventions](https://guides.rubyonrails.org/active_record_basics.html#naming-conventions) for classes, modules, table names, and associations. This consistency is crucial for maintaining code clarity and efficiency within the framework.

## Frequently Asked Questions (FAQ)

**Q: What should I do if I encounter an error stating that the master key is missing?**

**A:**

- Delete the existing `credentials.yml.enc` file to allow for the generation of new credentials: `rm config/credentials.yml.enc`.
- Open your credentials for editing with your preferred editor, e.g., `EDITOR="code --wait" rails credentials:edit`.
- After updating your credentials, save and close the editor to generate a new `master.key`.
- Securely configure the new `master.key` in your environment variables, but do not add it to version control.
- Remember to back up any essential data before making these changes.
