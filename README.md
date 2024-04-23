# [JobLogR](https://www.joblogr.org/) 🌐
### Simplify Your Job Application Process
<p align="center" width="100%">
<img alt="JobLogR Wireframe" width="700px" src="https://github.com/andrewp8/jobLogR/assets/69804999/45278cda-7791-40bd-8fe3-8144ea6c7403" />
</p>

## Overview

JobLogR aims to empower job seekers by providing a comprehensive tool to manage their job applications more efficiently, reducing the stress and disorganization often associated with the job search process.
## How to use JobLogR
<div style="position: relative; padding-bottom: 216.86746987951807%; height: 0;"><iframe src="https://www.loom.com/embed/6be4b4336cad4b779e56a52a8a244a10?sid=d8bd3487-16cc-46f3-b8cd-d81857cd9a16" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;"></iframe></div>

For a comprehensive guide, [see the full interactive version on Canva](https://www.canva.com/design/DAGDLMYiogo/I8uWXvDlHrTUJ45ehY2Pow/view?utm_content=DAGDLMYiogo&utm_campaign=designshare&utm_medium=link&utm_source=publishsharelink).

## Entity-Relationship Diagram (ERD)

Our application's database schema is visualized in the Entity-Relationship Diagram (ERD) below. This diagram provides a clear overview of the tables, their fields, and the relationships between them, facilitating a better understanding of how data is interconnected within our application.
<p align="center" width="100%">
<img alt="JobLogR Wireframe" width="700px" src="https://gist.github.com/assets/69804999/0265b70c-739b-4095-8846-b5dab2ac1182" />
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

1) Clone the repository and install dependencies:

     ```bash
    git clone https://github.com/andrewp8/jobLogR.git
    cd joblogr
    bundle install
    rails dev:reset  # Seeds the database with sample data
    rails active_storage:install
    rails db:migrate
    ```
2) **Create a `.env` file:**
    ```bash 
    touch .env
    ```
    - Inside the `.env` file, define your credentials using key-value pairs, one per line. Here's the format:
    - `API_KEY=your_secret_api_key`
3) Once you have met the prerequisites, you can start the Rails development server by running the following command in your terminal:

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
