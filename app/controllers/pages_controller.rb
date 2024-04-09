class PagesController < ApplicationController
  def landing
    @contents = [
      { caption: "Your AI-Powered Career Coach", body: "Leverage AI as your career coach with Joblogr, researching companies and consolidating job-related information in one spot, eliminating the need for repeated research on the same topics, streamlining your job search process.", img: "https://lottie.host/embed/d9d1d22d-5f77-4fb5-9172-b63e128e972c/BKyloZEJIc.json", label: "Animation illustrating an AI-powered career coach guiding a user through job search and application strategies.", img_back:"ai.png", alt: "Image showcasing the functionality of JobLogR's Career Coach." },
      { caption: "The career kit for the modern job-seeker", body: "Joblogr ensures secure storage of job details, enables tracking all applications in one location, simplifies planning your interview schedule, and allows job status updates with a single click, streamlining the job search process efficiently.", img: "https://lottie.host/embed/35cbc379-89a2-4fff-bdd6-d66cda49b230/v6ZpYC1mBZ.json", label: "An animation picture showing the seamless tracking and management of job applications in the Job Tracking Manager.", img_back:"tracker.png", alt: "Image showcasing the functionality of JobLogR's job tracking management." },
      { caption: "Maximize Your Application Impact", body: "Maximize your job application success with JobScore Tracker. Our innovative point system rewards progress, tracking each interview stage for insightful effectiveness scoring. Monitor resume versions and cover letters used per application. With our smart sorting, effortlessly identify positions needing a follow-up after 6 months.", img: "https://lottie.host/embed/5bd82196-5aa3-4c45-b78f-5e3b631efd2e/rFEFtzoBEp.json", label: "Visualization of the JobLogR's analyzing tool", img_back:"graph.png", alt: "Image showcasing the functionality of JobLogR's analyzing tool."  },
    ]

    render "landing"
  end
end
