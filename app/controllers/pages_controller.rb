class PagesController < ApplicationController
  skip_after_action :verify_authorized, only: [:landing, :about, :how_to_use, :feedback]

  def landing
    # I would move this to the view
    @contents = [
      { caption: "Your AI-Powered Career Coach", body: "Leverage AI as your career coach with JobRecorder, researching companies and consolidating job-related information in one spot, eliminating the need for repeated research on the same topics, streamlining your job search process.", img: "https://lottie.host/embed/d9d1d22d-5f77-4fb5-9172-b63e128e972c/BKyloZEJIc.json", label: "Animation illustrating an AI-powered career coach guiding a user through job search and application strategies.", img_back: "ai.png", alt: "Image showcasing the functionality of JobRecorder's Career Coach." },
      { caption: "The career kit for the modern job-seeker", body: "JobRecorder ensures secure storage of job details, enables tracking all applications in one location, simplifies planning your interview schedule, and allows job status updates with a single click, streamlining the job search process efficiently.", img: "https://lottie.host/embed/35cbc379-89a2-4fff-bdd6-d66cda49b230/v6ZpYC1mBZ.json", label: "An animation picture showing the seamless tracking and management of job applications in the Job Tracking Manager.", img_back: "tracker.png", alt: "Image showcasing the functionality of JobRecorder's job tracking management." },
      { caption: "Maximize Your Application Impact", body: "Maximize your job application success with JobRecorder. Our innovative point system rewards progress, tracking each interview stage for insightful effectiveness scoring. Monitor resume versions and cover letters used per application. With our smart sorting, effortlessly identify positions needing a follow-up after 6 months.", img: "https://lottie.host/embed/e87666a0-d2b8-425f-8d1f-bcceb5a5ba6c/crqLM5zl3z.json", label: "Visualization of the JobRecorder's analyzing tool", img_back: "graph.png", alt: "Image showcasing the functionality of JobRecorder's analyzing tool." },
    ]

    @testimonials = [
      { name: "Taylor Martinez", img: "https://thispersondoesnotexist.com/", body: "As a frequent job applicant, I've always dreaded the tedious process of managing different accounts and remembering countless passwords. With JobRecorder, signing in has never been easier or more secure, thanks to the Google authentication feature. It's just one click and I'm ready to manage my applications—no fuss, no hassle. This simplicity has truly changed the way I approach my job search." },
      { name: "Casey Johnson", img: "https://thispersondoesnotexist.com/", body: "Before using JobRecorder, I was overwhelmed by the volume of job applications I had to track manually. I would often lose track or duplicate applications. Now, with JobRecorder's smart application tracking system, I can see all my applications organized by status and date, and the app alerts me if I'm about to submit a duplicate application. It's like having a personal job search assistant who never misses a detail!" },
      { name: "Alex Thompson", img: "https://thispersondoesnotexist.com/", body: "I was skeptical about how much an app could really help with my job applications, but JobRecorder proved me wrong. The AI-powered search engine integration offers personalized advice and insights for each application I submit. Whether it's tweaking my resume or preparing for an interview, the tailored suggestions from JobRecorder have been invaluable. It's like having a career coach in my pocket!" },
    ]
  end

  def about
  end

  def how_to_use
  end

  def feedback
  end
end
