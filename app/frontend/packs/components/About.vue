<template>
  <div class="about-view-wrapper">
    <div class="flex-between my-profile">
      <img class="avatar" src="https://freeway-devland.s3.amazonaws.com/uploads/attached_photo/photo/517/opt_web_7c81c506-5461-4ab0-beab-a68a25bab2d3.png">
      <div class="intro">
        <h1>Linh Nguyen (me)</h1>
        <div class="contact-info">
        <p>github <a class="repo-links" href="https://github.com/dieulinh/" rel="noopener noreferrer" target="_blank">https://github.com/dieulinh/</a></p>
          <p>twitter @linhvn09</p>
          <a href="https://www.linkedin.com/in/linhnguyen9" rel="noopener noreferrer" target="_blank">Linkedin </a>
          <p>
          <a href="https://www.credly.com/users/dieu-linh-nguyen.82c92b0f" rel="noopener noreferrer" target="_blank">Credly</a>
          </p>
        </div>
      </div>
    </div>
    <div class="main pd-20">
      <div>
        <div class="head-intro">
          <p>My name is Linh Nguyen, I am a senior software engineer who works mostly on <strong> Ruby on Rails</strong> and <strong>Nodejs</strong>, <strong>React</strong> or <strong>Vuejs</strong></p>
          <p>In the past 8 years I have been working on building API for web apps, using Cloud Infrastructure like AWS and Google Cloud</p>
          I love travel, scuba diving, hiking and some other sports
        </div>
        <p>Shoot me a message at <a href="/#/contact"> <strong>contact</strong></a> link if you need other information</p>
        <p><br></p>
        <div class="experience-skills">
          <ul class="high-skills">
            <li>
              <strong>8+ years</strong> of professional experience as a web developer in <strong>Ruby on Rails</strong> framework with solid knowledge in Ruby programming language, metaprogramming, Ruby on Rails design patterns, developed  web apps and API for mobile apps. Experienced all major aspects of Ruby on Rails for backend and API development
            </li>
            <li>
              <strong>5+ years</strong> of professional experience working with JavaScript including JQuery,  AJAX and JSON , Vuejs, ReactJS, AngularJS
            </li>
            <li>
              Strong experience of using version control tools like Git
            </li>
            <li>
              Hands-on experience of using <strong>SQL</strong> including <strong>MySQL<strong>, </strong>PostgreSQL</strong>
            </li>
            <li>
              Familiar with <strong>Nodejs</strong>, GraphQL, <strong>Express</strong>, Webpack
            </li>
            <li>
              Strong experience of using <strong>Docker</strong>, Continuous Integration, Jenkins
            </li>
            <li>
              Hands-on experience with <strong>Kubernetes</strong>,<strong> Google Cloud Platform</strong>
            </li>
            <li>
              Hands-on experience using <strong>Amazon S3</strong>, <strong>EC2</strong>, <strong>AWS Elasticbeanstalk</strong>,<strong> ECR</strong> and other AWS Services
            </li>
            <li>
              Familiar with using Redis
            </li>
            <li>
              Familiar with using Elasticsearch and full-text search
            </li>
            <li>
              Comprehensive understanding of Unix/Linux Operating System
            </li>
            <li>
              Hands-on experience using heroku and other saas like DigitalOcean, Linode
            </li>
            <li> Some experiments with Machine learning, data analytics and more</li>

          </ul>
        </div>
        <ul class="high-skills">
          <li>Javascript (<strong>Nodejs</strong>, <strong>React</strong>, <strong>Vue</strong>)</li>
          <li><strong>Ruby (on Rails)</strong></li>
          <li><strong>API development</strong></li>
          <li>SQL(Postgres, MySQL)</li>
          <li>Elasticsearch</li>
          <li>GitHub</li>
          <li>AWS Cloud platform</li>
          <li><strong>Kubernetes</strong></li>
          <li>Workers/jobs/queues</li>
          <li>Testing tools/frameworks</li>
          <li><strong>Docker</strong></li>
          <li>GitHub Actions</li>
          <li>Studying Data Science</li>
        </ul>


      </div>
      <br>
      <!---->
      <br>
      <div></div>
    </div>

</div>
</template>
<script>
import server from "../services/Server";

export default {


  data() {
    return {}
  },
  mounted(){
    this.$store.dispatch('hide_right_panel', true)
  },
  computed: {

  },
  methods: {

  },
  created() {


  }
}
</script>