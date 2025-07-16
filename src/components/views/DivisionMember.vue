    <script setup lang="ts">
    import { ref, computed, onMounted, onBeforeUnmount, watch, defineAsyncComponent, nextTick } from 'vue'
    import { useRoute } from 'vue-router'
    import MemberCardDisplay from './MemberCardDisplay.vue' 

    const Navbar = defineAsyncComponent(() => import('../Navbar.vue'))
    const Footer = defineAsyncComponent(() => import('../Footer.vue'))

    interface Division {
      name: string
      title: string
      image: string
      description: string
    }

    interface Member {
      id: number
      status: string
      name: string
      email: string
      position: string
      cabinet: string
      batch: string
      division: string
      avatar: string
      instagram: string
      linkedin: string
      personalDescription: string
    }
    const divisions = [
      { name: 'BOD', title: 'Board of Directors', image: '/PUMA-Website/division/bod.JPG', description: 'Strategic leadership and organizational governance, overseeing all major decisions and future planning for the organization.' },
      { name: 'RNT', title: 'Research and Technology', image: '/PUMA-Website/division/rnt.jpg', description: 'Focuses on innovation, technological advancements, and exploring new tools to enhance organizational capabilities.' },
      { name: 'HRD', title: 'Human Resources Development', image: '/PUMA-Website/division/hrd.JPG', description: 'Dedicated to talent acquisition, member development, training programs, and fostering a positive organizational culture.' },
      { name: 'ICM', title: 'Information and Creative Media', image: '/PUMA-Website/division/icm.JPG', description: 'Manages digital communication, content creation, branding, and all media-related activities to project our image.' },
      { name: 'IR', title: 'Internal Relations', image: '/PUMA-Website/division/internal.JPG', description: 'Tasked with building strong internal connections, organizing member events, and ensuring smooth intra-divisional collaborations.' },
      { name: 'ER', title: 'External Relations', image: '/PUMA-Website/division/EXT.JPG', description: 'Handles external partnerships, public relations, networking with other organizations, and managing our external stakeholder interactions.' },
      { name: 'SAC', title: 'Student Academic & Competition', image: '/PUMA-Website/division/sac.JPG', description: 'Supports members in their academic pursuits and facilitates participation in various competitions to foster excellence.' },
      { name: 'SPT', title: 'Student Passions & Talents', image: '/PUMA-Website/division/spt.JPG', description: 'Nurtures individual creativity, hobbies, and talents by providing platforms and resources for members to explore their interests.' },
      { name: 'TECHNOPRENEUR', title: 'Technopreneur', image: '/PUMA-Website/division/Technoprenet.JPG', description: 'Drives entrepreneurship in technology and innovation, guiding members in developing tech-based business ideas.' }
    ];

    const cabinets = ['Kaustav', 'Fragnatious'];

    const generateMembers = () => {
      const membersList = [
        {
          "id": 1,
          "name": "Abdurrahman Khairi",
          "email": "-",
          "position": "Chairperson",
          "cabinet": "Kaustav Cabinet",
          "batch": "2023",
          "division": "BOD",
          "avatar": "/PUMA-Website/khairi.JPG",
          "instagram": "https://instagram.com/",
          "linkedin": "https://linkedin.com/in/",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 2,
          "name": "Filbert Sembiring Meliala",
          "email": "-",
          "position": "Vice Chairperson 1",
          "cabinet": "Kaustav Cabinet",
          "batch": "2023",
          "division": "BOD",
          "avatar": "/PUMA-Website/filbert.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 3,
          "name": "Leonardo Dos Santos",
          "email": "-",
          "position": "Vice Chairperson 2",
          "cabinet": "Kaustav Cabinet",
          "batch": "2023",
          "division": "BOD",
          "avatar": "/PUMA-Website/leonardo.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 4,
          "name": "Moshe Dayan",
          "email": "-",
          "position": "Senior Treasurer",
          "cabinet": "Kaustav Cabinet",
          "batch": "2023",
          "division": "BOD",
          "avatar": "/PUMA-Website/moshe.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 5,
          "name": "Elvia Aptanisa",
          "email": "-",
          "position": "Junior Treasurer",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "BOD",
          "avatar": "/PUMA-Website/elvi.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 6,
          "name": "Michelle",
          "email": "-",
          "position": "Junior Treasurer",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "BOD",
          "avatar": "/PUMA-Website/michelle.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 7,
          "name": "Desy Nursalsabila",
          "email": "-",
          "position": "Senior Secretary",
          "cabinet": "Kaustav Cabinet",
          "batch": "2023",
          "division": "BOD",
          "avatar": "/PUMA-Website/desy.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 8,
          "name": "Putri Zahara",
          "email": "-",
          "position": "Junior Secretary",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "BOD",
          "avatar": "/PUMA-Website/putri.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 9,
          "name": "Zuldan Fahrizal Rahman",
          "email": "-",
          "position": "Junior Secretary",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "BOD",
          "avatar": "/PUMA-Website/zuldan.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 10,
          "name": "Isya Maghfira Zalfa",
          "email": "-",
          "position": "Head of External Relation",
          "cabinet": "Kaustav Cabinet",
          "batch": "2023",
          "division": "ER",
          "avatar": "/PUMA-Website/cica.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 11,
          "name": "Sarahwati",
          "email": "-",
          "position": "Vice of External Relation",
          "cabinet": "Kaustav Cabinet",
          "batch": "2023",
          "division": "ER",
          "avatar": "/PUMA-Website/sarah.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 12,
          "name": "Shanty",
          "email": "-",
          "position": "Member of External Relation",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "ER",
          "avatar": "/PUMA-Website/shanty.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 13,
          "name": "Naufal Rizki Pinugroho",
          "email": "-",
          "position": "Member of External Relation",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "ER",
          "avatar": "/PUMA-Website/nopal.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 14,
          "name": "Made Mas Pradnya Prabawa",
          "email": "-",
          "position": "Member of External Relation",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "ER",
          "avatar": "/PUMA-Website/prad.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 15,
          "name": "Gideon Anggara Siagian",
          "email": "-",
          "position": "Member of External Relation",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "ER",
          "avatar": "/PUMA-Website/gideon.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 16,
          "name": "Bianca Vallerie",
          "email": "-",
          "position": "Head of Internal Relation",
          "cabinet": "Kaustav Cabinet",
          "batch": "2023",
          "division": "IR",
          "avatar": "/PUMA-Website/bianca.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 17,
          "name": "Abigail Tiara Larasati",
          "email": "-",
          "position": "Vice of Internal Relation",
          "cabinet": "Kaustav Cabinet",
          "batch": "2023",
          "division": "IR",
          "avatar": "/PUMA-Website/bigel.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 18,
          "name": "Johana Veronica Setiawan",
          "email": "-",
          "position": "Member of Internal Relation",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "IR",
          "avatar": "/PUMA-Website/joana.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 19,
          "name": "Muhammad Dzaki Abrar",
          "email": "-",
          "position": "Member of Internal Relation",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "IR",
          "avatar": "/PUMA-Website/dzaki.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 20,
          "name": "Zain Akbar",
          "email": "-",
          "position": "Member of Internal Relation",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "IR",
          "avatar": "/PUMA-Website/akbar.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 21,
          "name": "hana Khairunnisa Nabiilah",
          "email": "-",
          "position": "Head of Student Academic and Competition",
          "cabinet": "Kaustav Cabinet",
          "batch": "2023",
          "division": "SAC",
          "avatar": "/PUMA-Website/hana.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 22,
          "name": "Sarah Kimberly Fischer",
          "email": "-",
          "position": "Vice of Student Academy and Competition",
          "cabinet": "Kaustav Cabinet",
          "batch": "2023",
          "division": "SAC",
          "avatar": "/PUMA-Website/kim.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 23,
          "name": "Lutfi Maulana",
          "email": "-",
          "position": "Member of Student Academy and Competition",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "SAC",
          "avatar": "/PUMA-Website/lutfi.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 24,
          "name": "Wilbert Leonard Harriman",
          "email": "-",
          "position": "Member of Student Academy and Competition",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "SAC",
          "avatar": "/PUMA-Website/wilbert.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 25,
          "name": "Yasmin Raihanah Inayudha",
          "email": "-",
          "position": "Member of Student Academy and Competition",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "SAC",
          "avatar": "/PUMA-Website/yasmin.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 26,
          "name": "Cut Kheysa Sakbania",
          "email": "-",
          "position": "Member of Student Academy and Competition",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "SAC",
          "avatar": "/PUMA-Website/cut.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 27,
          "name": "Made Mahatti Prayascita Chandra",
          "email": "-",
          "position": "Head of Information and Creative Media",
          "cabinet": "Kaustav Cabinet",
          "batch": "2023",
          "division": "ICM",
          "avatar": "/PUMA-Website/mahatti.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 28,
          "name": "Nadifah Aulia Rahmani",
          "email": "-",
          "position": "Vice of Media Information",
          "cabinet": "Kaustav Cabinet",
          "batch": "2023",
          "division": "ICM",
          "avatar": "/PUMA-Website/nadifah.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 29,
          "name": "Muhammad Afdal Fikri",
          "email": "-",
          "position": "Member of Media Infromation",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "ICM",
          "avatar": "/PUMA-Website/afdal.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 30,
          "name": "Naila Olivia",
          "email": "-",
          "position": "Member of Media Infromation",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "ICM",
          "avatar": "/PUMA-Website/olivia.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 31,
          "name": "Azqa Difani Akbar",
          "email": "-",
          "position": "Vice of Creative Media",
          "cabinet": "Kaustav Cabinet",
          "batch": "2023",
          "division": "ICM",
          "avatar": "/PUMA-Website/azka.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 32,
          "name": "Gamma Ahmad Zaki Kurnia Budihardjo",
          "email": "-",
          "position": "Member of Creative Media",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "ICM",
          "avatar": "/PUMA-Website/gamma.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 33,
          "name": "Almira Shinta Aulia",
          "email": "-",
          "position": "Member of Creative Media",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "ICM",
          "avatar": "/PUMA-Website/almira.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 34,
          "name": "Richie Obasa",
          "email": "-",
          "position": "Member of Creative Media",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "ICM",
          "avatar": "/PUMA-Website/richie.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 35,
          "name": "Gabriel Hamonangan Lumban Tobing",
          "email": "-",
          "position": "Member of Creative Media",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "ICM",
          "avatar": "/PUMA-Website/hamongan.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 36,
          "name": "Raisya Eka Putri",
          "email": "-",
          "position": "Member of Creative Media",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "ICM",
          "avatar": "/PUMA-Website/raisya.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 37,
          "name": "Kevin Syonin",
          "email": "-",
          "position": "Member of Creative Media",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "ICM",
          "avatar": "/PUMA-Website/kevin.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 38,
          "name": "Dewa Anggara Satria Pratama",
          "email": "-",
          "position": "Member of Creative Media",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "ICM",
          "avatar": "/PUMA-Website/dewa.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 39,
          "name": "Rix Valdo",
          "email": "-",
          "position": "Head of Research and Technology",
          "cabinet": "Kaustav Cabinet",
          "batch": "2023",
          "division": "RNT",
          "avatar": "/PUMA-Website/rix.jpg",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 40,
          "name": "Jason Anthony Wibowo",
          "email": "-",
          "position": "Vice of Research and Technology",
          "cabinet": "Kaustav Cabinet",
          "batch": "2023",
          "division": "RNT",
          "avatar": "/PUMA-Website/jason.jpg",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 41,
          "name": "Muhammad Haikal Islami",
          "email": "-",
          "position": "Member of Research and Technology",
          "cabinet": "Kaustav Cabinet",
          "batch": "2023",
          "division": "RNT",
          "avatar": "/PUMA-Website/haikal.jpg",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 42,
          "name": "Briant Jasper",
          "email": "-",
          "position": "Member of Research and Technology",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "RNT",
          "avatar": "/PUMA-Website/briant.jpg",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 43,
          "name": "Keira Nevrada Lay",
          "email": "-",
          "position": "Member of Research and Technology",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "RNT",
          "avatar": "/PUMA-Website/keira.jpg",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 44,
          "name": "Janet Dewi Evangeline",
          "email": "-",
          "position": "Member of Research and Technology",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "RNT",
          "avatar": "/PUMA-Website/jane.jpg",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 45,
          "name": "Nisrina Izza Nur Aisyah",
          "email": "-",
          "position": "Member of Research and Technology",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "RNT",
          "avatar": "/PUMA-Website/nina.jpg",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 46,
          "name": "Ubaidillah Al-Azhar",
          "email": "-",
          "position": "Head of Technopreneur",
          "cabinet": "Kaustav Cabinet",
          "batch": "2023",
          "division": "TECHNOPRENEUR",
          "avatar": "/PUMA-Website/ubai.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 47,
          "name": "Salsa Ica Indriani",
          "email": "-",
          "position": "Vice of Technopreneur",
          "cabinet": "Kaustav Cabinet",
          "batch": "2023",
          "division": "TECHNOPRENEUR",
          "avatar": "/PUMA-Website/ica.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 48,
          "name": "Navisa Ersa Sabina",
          "email": "-",
          "position": "Member of Technopreneur",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "TECHNOPRENEUR",
          "avatar": "/PUMA-Website/sasa.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 49,
          "name": "Michael Bryan Mandey",
          "email": "-",
          "position": "Member of Technopreneur",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "TECHNOPRENEUR",
          "avatar": "/PUMA-Website/michael.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 50,
          "name": "Nailha Sakhila Dewi",
          "email": "-",
          "position": "Member of Technopreneur",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "TECHNOPRENEUR",
          "avatar": "/PUMA-Website/nailha.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 51,
          "name": "Joy Adelia Sihombing",
          "email": "-",
          "position": "Head of Human Resources Development",
          "cabinet": "Kaustav Cabinet",
          "batch": "2023",
          "division": "HRD",
          "avatar": "/PUMA-Website/joy.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 52,
          "name": "Intan Kumala Pasya",
          "email": "-",
          "position": "Vice of Human Resources Development",
          "cabinet": "Kaustav Cabinet",
          "batch": "2023",
          "division": "HRD",
          "avatar": "/PUMA-Website/intan.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 53,
          "name": "Tio Muhammad Rizky",
          "email": "-",
          "position": "Member of Human Resources Development",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "HRD",
          "avatar": "/PUMA-Website/tio.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 54,
          "name": "Angelina Yolanda Christin Lubis",
          "email": "-",
          "position": "Member of Human Resources Development",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "HRD",
          "avatar": "/PUMA-Website/angel.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 55,
          "name": "Ernest Teo",
          "email": "-",
          "position": "Head of Student Passions and Talents",
          "cabinet": "Kaustav Cabinet",
          "batch": "2023",
          "division": "SPT",
          "avatar": "/PUMA-Website/ernest.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 56,
          "name": "Rivan Meinaki",
          "email": "-",
          "position": "Vice of Student Passions and Talents",
          "cabinet": "Kaustav Cabinet",
          "batch": "2023",
          "division": "SPT",
          "avatar": "/PUMA-Website/rivan.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 57,
          "name": "Wisnu Alfian Nur Ashar",
          "email": "-",
          "position": "Member of Student Passions and Talents",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "SPT",
          "avatar": "/PUMA-Website/wisnu.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 58,
          "name": "Fauzan Fajri",
          "email": "-",
          "position": "Member of Student Passions and Talents",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "SPT",
          "avatar": "/PUMA-Website/fauzan.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 59,
          "name": "Qwyn Celine Djimondo",
          "email": "-",
          "position": "Member of Student Passions and Talents",
          "cabinet": "Kaustav Cabinet",
          "batch": "2024",
          "division": "SPT",
          "avatar": "/PUMA-Website/qwin.JPG",
          "instagram": "https://instagram.com/martha_nielsen",
          "linkedin": "https://linkedin.com/in/martha-nielsen",
          "personalDescription": "-",
          "status": "Active"
        },
        {
          "id": 60,
          "name": "Fragnatious Member 1 BOD",
          "email": "kopi1@example.com",
          "position": "Chairperson",
          "cabinet": "Fragnatious",
          "batch": "2023",
          "division": "BOD",
          "avatar": "/PUMA-Website/avatar2.png",
          "instagram": "https://instagram.com/",
          "linkedin": "https://linkedin.com/in/",
          "personalDescription": "Fragnatious Cabinet Leader",
          "status": "Active"
        },
        {
          "id": 61,
          "name": "Fragnatious Member 2 RNT",
          "email": "kopi2@example.com",
          "position": "Head of RNT",
          "cabinet": "Fragnatious",
          "batch": "2023",
          "division": "RNT",
          "avatar": "/PUMA-Website/avatar2.png",
          "instagram": "https://instagram.com/",
          "linkedin": "https://linkedin.com/in/",
          "personalDescription": "Fragnatious RNT Head",
          "status": "Active"
        }
      ];

      return membersList;
    };


    const allMembersFullList = ref<Member[]>([]);
    const route = useRoute();
    const currentDivisionNameFromRoute = ref<string>('');
    const currentDivisionTitle = ref<string>('Division');
    const currentDivisionInfo = ref<Division | null>(null);
    const membersForCurrentDivision = ref<Member[]>([]);
    const selectedCabinet = ref<string>('all');
    const searchQuery = ref<string>('');
    const debouncedSearchQuery = ref<string>('');
    let debounceTimer: number | undefined;
    const isLoading = ref<boolean>(true);
    const selectedMember = ref<Member | null>(null);
    const isModalOpen = ref<boolean>(false);

    watch(searchQuery, (newValue) => {
      clearTimeout(debounceTimer);
      debounceTimer = window.setTimeout(() => {
        debouncedSearchQuery.value = newValue;
      }, 300);
    });

    const filteredMembers = computed(() => {
      let result = [...membersForCurrentDivision.value];
      if (selectedCabinet.value !== 'all') {
        result = result.filter(member => member.cabinet === selectedCabinet.value || member.cabinet === `${selectedCabinet.value} Cabinet`);
      }
      if (debouncedSearchQuery.value) {
        const query = debouncedSearchQuery.value.toLowerCase();
        result = result.filter(member =>
          member.name.toLowerCase().includes(query) ||
          member.email.toLowerCase().includes(query) ||
          member.position.toLowerCase().includes(query)
        );
      }
      return result;
    });

    const visibleMemberIds = ref(new Set<number>());
    const memberRefs = ref<Map<number, HTMLElement>>(new Map());
    let observer: IntersectionObserver | null = null;

    const CARD_HEIGHT_PX = 460;

    const setupObserver = () => {
      if (observer) {
        observer.disconnect();
      }
      const options = {
        root: null, 
        rootMargin: '200px 0px 200px 0px', 
        threshold: 0.01 
      };
      observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
          const memberId = parseInt(entry.target.getAttribute('data-member-id') || '0', 10);
          if (!memberId) return;
          if (entry.isIntersecting) {
            visibleMemberIds.value.add(memberId);
          } else {
            // To aggressively un-render items when they scroll far out of view (more performant but might cause content to "disappear" if user scrolls back fast):
            visibleMemberIds.value.delete(memberId);
            // For a smoother experience, you might not delete here, relying on filter changes to clear 'visibleMemberIds'.
          }
        });
      }, options);

      // Observe all current member reference elements
      memberRefs.value.forEach(el => {
        if (el && observer) { // Ensure el and observer exist
            observer.observe(el);
        }
      });
    };

    const setMemberRef = (el: any, memberId: number) => {
      if (el) {
        memberRefs.value.set(memberId, el as HTMLElement);
      } else {
        memberRefs.value.delete(memberId); // Clean up ref when element is unmounted
      }
    };

    watch(filteredMembers, async () => {
      // When the list of filtered members changes, reset visibility and re-setup the observer
      visibleMemberIds.value.clear();
      const oldRefs = new Map(memberRefs.value); // Keep a copy of old refs to unobserve them
      memberRefs.value.clear();

      if (observer) { // Unobserve elements tied to the old list
        oldRefs.forEach(el => observer?.unobserve(el));
      }

      isLoading.value = true; // Indicate loading while DOM updates and observer is reconfigured
      await nextTick(); // Wait for the DOM to update with the new set of member slots
      setupObserver(); // Setup observer for the new elements
      setTimeout(() => isLoading.value = false, 100); // Short delay for visual feedback, or tie to a more concrete "ready" state
    }, { deep: false }); // Use deep: false if only array replacement triggers re-check, true if item properties change and require re-eval

    onBeforeUnmount(() => {
      if (observer) {
        observer.disconnect();
      }
      clearTimeout(debounceTimer);
    });

    const getStatusColor = (status: string) => {
      switch (status.toLowerCase()) {
        case 'active': return 'bg-green-100 text-green-800 border-green-300 font-mono';
        case 'inactive': return 'bg-gray-200 text-gray-700 border-gray-400 font-mono';
        case 'alumni': return 'bg-slate-100 text-slate-700 border-slate-300 font-mono';
        default: return 'bg-gray-200 text-gray-700 border-gray-400 font-mono';
      }
    };
    const getStatusDot = (status: string) => {
      switch (status.toLowerCase()) {
        case 'active': return 'bg-green-500';
        case 'inactive': return 'bg-gray-400';
        case 'alumni': return 'bg-slate-500';
        default: return 'bg-gray-400';
      }
    };
    const getDivisionTitleByCode = (code: string): string => {
      const division = divisions.find(d => d.name === code);
      return division ? division.title : code;
    };


    const loadDivisionData = async () => {
      isLoading.value = true;
      currentDivisionNameFromRoute.value = route.params.divisionName as string;
      const divisionDetails = divisions.find(d => d.name === currentDivisionNameFromRoute.value);
      currentDivisionTitle.value = divisionDetails ? divisionDetails.title : (currentDivisionNameFromRoute.value || 'Division');
      currentDivisionInfo.value = divisionDetails || null;

      if (allMembersFullList.value.length === 0) {
        allMembersFullList.value = generateMembers();
      }
      membersForCurrentDivision.value = allMembersFullList.value.filter(
        member => member.division === currentDivisionNameFromRoute.value
      );
    };

    const openModal = (member: Member) => {
      selectedMember.value = member;
      isModalOpen.value = true;
      document.body.style.overflow = 'hidden';
    };
    const closeModal = () => {
      isModalOpen.value = false;
      selectedMember.value = null;
      document.body.style.overflow = 'unset';
    };

    onMounted(() => {
      loadDivisionData();
      debouncedSearchQuery.value = searchQuery.value;
    });

    watch(() => route.params.divisionName, (newDivisionName) => {
      if (newDivisionName) {
        selectedCabinet.value = 'all';
        searchQuery.value = '';
        debouncedSearchQuery.value = ''; // Important to reset for observer updates
        loadDivisionData();
      }
    });

    </script>

    <template>
      <Navbar />
      <div class="relative min-h-screen pt-16 bg-gradient-to-br from-white via-gray-50 to-slate-100">
        <div class="absolute inset-0 dot-background-members"></div>
        <div class="absolute inset-0 opacity-10"
          style="background-image: radial-gradient(circle at 1px 1px, rgba(100,116,139,0.1) 1px, transparent 0); background-size: 28px 28px;">
        </div>

        <section class="relative z-10 pt-12 pb-16 shadow-md bg-white/80 backdrop-blur-sm">
          <div class="container relative px-6 mx-auto">
            <div class="grid items-center gap-12 lg:grid-cols-2">
              <div class="relative z-10">
                <div class="mb-5">
                  <span
                    class="inline-block px-3 py-1.5 mb-3 text-xs font-bold tracking-wider text-gray-700 uppercase bg-gray-200 border border-gray-300 rounded-sm font-mono transform -rotate-1">
                    Division dossier: {{ currentDivisionNameFromRoute }}
                  </span>
                  <h1 class="font-mono text-4xl font-bold text-gray-800 lg:text-5xl xl:text-6xl">
                    {{ currentDivisionTitle }}
                  </h1>
                </div>
                <p class="mb-6 font-mono text-base leading-relaxed text-gray-600 lg:text-lg">
                  {{ currentDivisionInfo?.description || 'Reviewing operatives and assets within this unit.' }}
                </p>
                <div class="flex flex-wrap gap-4 text-sm">
                  <div class="flex items-center gap-3 px-5 py-3 border border-gray-300 rounded-lg shadow-sm bg-gray-50">
                    <div class="flex items-center justify-center w-10 h-10 bg-gray-600 rounded-md">
                      <svg class="w-5 h-5 text-white" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd" /></svg>
                    </div>
                    <div>
                      <p class="font-mono text-lg font-bold text-gray-800">{{ membersForCurrentDivision.length }}</p> <p class="font-mono text-xs text-gray-500 uppercase">Operatives in Division</p>
                    </div>
                  </div>
                  <div class="flex items-center gap-3 px-5 py-3 border border-gray-300 rounded-lg shadow-sm bg-gray-50">
                    <div class="flex items-center justify-center w-10 h-10 bg-gray-600 rounded-md">
                      <svg class="w-5 h-5 text-white" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M6 6V5a3 3 0 013-3h2a3 3 0 013 3v1h2a2 2 0 012 2v3.57A22.952 22.952 0 0110 13a22.95 22.95 0 01-8-1.43V8a2 2 0 012-2h2zm2-1a1 1 0 011-1h2a1 1 0 011 1v1H8V5zm1 5a1 1 0 011-1h.01a1 1 0 110 2H10a1 1 0 01-1-1z" clip-rule="evenodd" /></svg>
                    </div>
                    <div>
                      <p class="font-mono text-lg font-bold text-gray-800">{{ cabinets.length }}</p>
                      <p class="font-mono text-xs text-gray-500 uppercase">Cabinets</p>
                    </div>
                  </div>
                </div>
              </div>
              <div class="relative hidden lg:block">
                <div class="p-1 overflow-hidden transition-transform duration-300 transform bg-gray-100 border border-gray-300 shadow-xl rounded-xl rotate-1 hover:rotate-0">
                  <img :src="currentDivisionInfo?.image || 'https://via.placeholder.com/600x400/e5e7eb/4b5563?text=Division+Archive'" :alt="currentDivisionTitle" class="object-cover w-full rounded-lg h-80 lg:h-96" loading="lazy" />
                </div>
                <div class="absolute z-20 w-3 h-3 bg-gray-700 rounded-full shadow-md -top-3 left-8"></div>
                <div class="absolute z-20 w-3 h-3 rounded-full shadow-md bg-slate-600 -bottom-3 right-8"></div>
              </div>
            </div>
          </div>
        </section>

        <section class="z-20 py-6 border-t border-b border-gray-200 bg-white/70 backdrop-blur-sm top-16">
          <div class="container px-6 mx-auto">
            <div class="flex flex-col gap-4 lg:flex-row lg:items-center">
              <div class="flex-1">
                <div class="relative">
                  <div class="absolute inset-y-0 left-0 flex items-center pl-4 pointer-events-none"><svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" /></svg></div>
                  <input type="text" v-model="searchQuery" placeholder="Search operatives by name, email, position..." class="w-full py-3 pl-10 pr-4 font-mono text-sm text-gray-900 placeholder-gray-500 transition-all border-2 border-gray-300 rounded-lg bg-gray-50 focus:ring-2 focus:ring-gray-500 focus:bg-white focus:border-gray-400" />
                </div>
              </div>
              <div class="lg:w-64">
                <div class="relative">
                  <select v-model="selectedCabinet" class="w-full py-3 pl-4 pr-10 font-mono text-sm text-gray-900 transition-all border-2 border-gray-300 rounded-lg appearance-none bg-gray-50 focus:ring-2 focus:ring-gray-500 focus:bg-white focus:border-gray-400">
                    <option value="all">All Cabinets</option>
                    <option v-for="cabinetItem in cabinets" :key="cabinetItem" :value="cabinetItem">{{ cabinetItem }}</option>
                  </select>
                  <div class="absolute inset-y-0 right-0 flex items-center px-4 pointer-events-none"><svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path></svg></div>
                </div>
              </div>
            </div>
            <div class="flex items-center justify-start mt-4">
              <div class="font-mono text-xs text-gray-600 uppercase">
                <span v-if="!isLoading || filteredMembers.length > 0" class="font-medium">{{ filteredMembers.length }} record{{ filteredMembers.length === 1 ? '' : 's' }} found</span>
                <span v-else-if="isLoading" class="font-medium">Processing query...</span>
              </div>
            </div>
          </div>
        </section>

        <section class="relative z-10 py-12">
          <div class="container px-6 mx-auto">
            <div v-if="isLoading && filteredMembers.length === 0" class="flex items-center justify-center py-24">
                <div class="flex flex-col items-center"><div class="relative"><div class="w-12 h-12 border-4 border-gray-200 rounded-full"></div><div class="absolute top-0 left-0 w-12 h-12 border-4 border-gray-700 rounded-full animate-spin border-t-transparent"></div></div><p class="mt-4 font-mono font-medium text-gray-600">Loading operatives...</p></div>
            </div>
            <div v-else>
              <div v-if="filteredMembers.length === 0 && !isLoading" class="py-24 text-center">
                <div class="max-w-md mx-auto"><div class="flex items-center justify-center w-16 h-16 mx-auto mb-5 bg-gray-100 border border-gray-300 rounded-lg"><svg class="w-8 h-8 text-gray-400" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M19.5 14.25v-2.625a3.375 3.375 0 00-3.375-3.375h-1.5A1.125 1.125 0 0113.5 7.125v-1.5a3.375 3.375 0 00-3.375-3.375H8.25m0 12.75h7.5m-7.5 3H12M10.5 2.25H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 00-9-9z" /></svg></div><h3 class="mb-2 font-mono text-xl font-semibold text-gray-800">No Operatives Found</h3><p class="font-mono text-sm text-gray-500">Adjust search parameters or cabinet filter.</p></div>
              </div>

              <div v-else class="grid grid-cols-1 gap-x-6 gap-y-10 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5">
                <div
                  v-for="(member, index) in filteredMembers"
                  :key="member.id"
                  :ref="el => setMemberRef(el, member.id)"
                  :data-member-id="member.id"
                  class="member-card-slot"
                  :style="{ minHeight: `${CARD_HEIGHT_PX}px` }"
                >
                  <MemberCardDisplay
                    v-if="visibleMemberIds.has(member.id)"
                    :member="member"
                    :index="index"
                    :open-modal-fn="openModal"
                  />
                  <div v-else class="flex items-center justify-center bg-gray-100 border border-gray-200 rounded-md card-placeholder" :style="{ height: `${CARD_HEIGHT_PX}px` }">
                    </div>
                </div>
              </div>
            </div>
          </div>
        </section>
      </div>
      <Footer />

      <div v-if="isModalOpen"
        class="fixed inset-0 z-50 flex items-center justify-center p-4 transition-opacity duration-300 bg-black/70 backdrop-blur-sm"
        :class="isModalOpen ? 'opacity-100' : 'opacity-0 pointer-events-none'" @click.self="closeModal">
        <div
          class="relative w-full max-w-3xl overflow-hidden transition-all duration-300 transform bg-gray-50 border border-gray-400 shadow-2xl rounded-xl max-h-[90vh] overflow-y-auto font-mono"
          :class="isModalOpen ? 'scale-100 opacity-100' : 'scale-95 opacity-0'" role="dialog" aria-modal="true"
          :aria-labelledby="selectedMember ? `modal-title-${selectedMember.id}` : undefined">
          <div class="absolute top-0 left-0 right-0 h-1.5 bg-gray-700"></div>
          <button @click="closeModal"
            class="absolute z-10 flex items-center justify-center w-10 h-10 transition-all rounded-lg bg-gray-200/80 hover:bg-gray-300 focus:outline-none focus:ring-2 focus:ring-gray-500 top-4 right-4"
            aria-label="Close modal">
            <svg class="w-5 h-5 text-gray-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
            </svg>
          </button>
          <div v-if="selectedMember" class="p-6 pt-12 sm:p-8 sm:pt-16">
            <div class="flex flex-col items-center gap-6 text-center sm:flex-row sm:text-left sm:gap-8">
              <div class="relative">
                <div class="overflow-hidden border-2 border-gray-300 rounded-lg shadow-md">
                  <img :src="selectedMember.avatar || 'https://via.placeholder.com/160/d1d5db/4b5563?text=ID'"
                    :alt="selectedMember.name" class="object-cover w-40 h-40 sm:w-48 sm:h-48" loading="lazy" />
                </div>
                <div
                  :class="['absolute w-7 h-7 border-2 border-gray-50 rounded-full shadow-sm -bottom-2 -right-2', getStatusDot(selectedMember.status)]">
                </div>
              </div>
              <div class="flex-1">
                <div class="flex flex-col items-center justify-center gap-2 mb-2 sm:flex-row sm:justify-start">
                  <h3 :id="`modal-title-${selectedMember.id}`" class="text-2xl font-bold text-gray-800 uppercase">{{
                    selectedMember.name }}</h3>
                  <span :class="['px-2.5 py-0.5 text-xs border rounded-sm', getStatusColor(selectedMember.status)]">
                    {{ selectedMember.status }}
                  </span>
                </div>
                <p class="mb-1 font-semibold text-gray-600 uppercase text-md">{{ selectedMember.position }}</p>
                <p class="text-sm text-gray-500">{{ selectedMember.email !== '-' ? selectedMember.email : 'No official contact' }}</p>
              </div>
            </div>
            <div class="pt-6 mt-6 space-y-5 border-t border-gray-300">
              <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
                <div class="p-4 border border-gray-200 rounded-lg shadow-sm bg-gradient-to-br from-gray-100 to-slate-100">
                  <div class="flex items-center gap-2.5 mb-2">
                    <div class="p-1.5 bg-gray-600 rounded-md"><svg class="w-4 h-4 text-white" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M6 6V5a3 3 0 013-3h2a3 3 0 013 3v1h2a2 2 0 012 2v3.57A22.952 22.952 0 0110 13a22.95 22.95 0 01-8-1.43V8a2 2 0 012-2h2zm2-1a1 1 0 011-1h2a1 1 0 011 1v1H8V5zm1 5a1 1 0 011-1h.01a1 1 0 110 2H10a1 1 0 01-1-1z" clip-rule="evenodd" /></svg></div><p class="text-xs font-semibold tracking-wide text-gray-700 uppercase">Cabinet Unit</p>
                  </div><p class="font-bold text-gray-800 text-md">{{ selectedMember.cabinet }}</p>
                </div>
                <div class="p-4 border border-gray-200 rounded-lg shadow-sm bg-gradient-to-br from-gray-100 to-neutral-100">
                  <div class="flex items-center gap-2.5 mb-2">
                    <div class="p-1.5 bg-gray-600 rounded-md"><svg class="w-4 h-4 text-white" fill="currentColor" viewBox="0 0 20 20"><path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" /></svg></div><p class="text-xs font-semibold tracking-wide text-gray-700 uppercase">Batch Entry</p>
                  </div><p class="font-bold text-gray-800 text-md">{{ selectedMember.batch }}</p>
                </div>
                <div class="p-4 border border-gray-200 rounded-lg shadow-sm bg-gradient-to-br from-gray-100 to-stone-100 sm:col-span-2 lg:col-span-1">
                  <div class="flex items-center gap-2.5 mb-2">
                    <div class="p-1.5 rounded-md bg-gray-600"><svg class="w-4 h-4 text-white" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd" /></svg></div><p class="text-xs font-semibold tracking-wide text-gray-700 uppercase">Assigned Division</p>
                  </div><p class="font-bold text-gray-800 text-md">{{ getDivisionTitleByCode(selectedMember.division) }}</p>
                </div>
              </div>
              <div class="p-4 border border-gray-200 rounded-lg shadow-sm bg-gradient-to-br from-gray-100 to-slate-100">
                <div class="flex items-center gap-2.5 mb-3">
                  <div class="p-1.5 bg-gray-700 rounded-md"><svg class="w-4 h-4 text-white" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M3 17a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm3.293-7.707a1 1 0 011.414 0L9 10.586V3a1 1 0 112 0v7.586l1.293-1.293a1 1 0 111.414 1.414l-3 3a1 1 0 01-1.414 0l-3-3a1 1 0 010-1.414z" clip-rule="evenodd" /></svg></div><p class="text-xs font-semibold tracking-wide text-gray-700 uppercase">Operational Status</p>
                </div><p class="text-sm text-gray-700">Operative is currently <span class="font-semibold">{{ selectedMember.status.toLowerCase() }}</span>.<span v-if="selectedMember.status === 'Alumni'" class="block mt-1 text-sm text-slate-600">Past contributions acknowledged.</span><span v-if="selectedMember.status === 'Inactive'" class="block mt-1 text-sm text-gray-500">Currently on reserve or inactive duty.</span></p>
              </div>
              <div v-if="selectedMember.personalDescription && selectedMember.personalDescription !== '-'" class="p-4 bg-white border border-gray-200 rounded-lg shadow-sm">
                <div class="flex items-center gap-2.5 mb-3"><div class="p-1.5 bg-gray-600 rounded-md"><svg class="w-4 h-4 text-white" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd" /></svg></div><p class="text-xs font-semibold tracking-wide text-gray-700 uppercase">Intelligence Brief</p></div><p class="text-sm leading-relaxed text-gray-700">{{ selectedMember.personalDescription }}</p>
              </div>
              <div class="p-4 bg-white border border-gray-200 rounded-lg shadow-sm">
                <div class="flex items-center gap-2.5 mb-3"><div class="p-1.5 bg-gray-600 rounded-md"><svg class="w-4 h-4 text-white" fill="currentColor" viewBox="0 0 20 20"><path d="M11 17a1 1 0 001.447.894l4-2A1 1 0 0017 15V9.236a1 1 0 00-1.447-.894l-4 2a1 1 0 00-.553.894V17zM15.211 6.276a1 1 0 000-1.788l-4.764-2.382a1 1 0 00-.894 0L4.789 4.488a1 1 0 000 1.788l4.764 2.382a1 1 0 00.894 0l4.764-2.382zM4.447 8.342A1 1 0 003 9.236V15a1 1 0 00.553.894l4 2A1 1 0 009 17v-5.764a1 1 0 00-.553-.894l-4-2z" /></svg></div><p class="text-xs font-semibold tracking-wide text-gray-700 uppercase">External Network</p></div><div class="flex gap-3"><a v-if="selectedMember.instagram && selectedMember.instagram !== 'https://instagram.com/'" :href="selectedMember.instagram" target="_blank" rel="noopener noreferrer" class="flex items-center justify-center w-10 h-10 transition-all bg-gray-200 rounded-md hover:bg-gray-300 group" aria-label="Instagram Profile"><svg class="w-5 h-5 text-gray-600 group-hover:text-gray-800" fill="currentColor" viewBox="0 0 24 24"><path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z" /></svg></a><a v-if="selectedMember.linkedin && selectedMember.linkedin !== 'https://linkedin.com/in/'" :href="selectedMember.linkedin" target="_blank" rel="noopener noreferrer" class="flex items-center justify-center w-10 h-10 transition-all bg-gray-200 rounded-md hover:bg-gray-300 group" aria-label="LinkedIn Profile"><svg class="w-5 h-5 text-gray-600 group-hover:text-gray-800" fill="currentColor" viewBox="0 0 24 24"><path d="M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z" /></svg></a><div v-if="(!selectedMember.instagram || selectedMember.instagram === 'https://instagram.com/') && (!selectedMember.linkedin || selectedMember.linkedin === 'https://linkedin.com/in/')" class="text-sm text-gray-500">No external links listed.</div></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </template>

    <style scoped>
    .member-card-slot {
      display: flex;
      flex-direction: column;
    }

    .card-placeholder {
      width: 100%;
      animation: pulse-bg 2s infinite ease-in-out;
      border-radius: 0.375rem; 
    }

    @keyframes pulse-bg {
      0% { background-color: #f9fafb; } 
      50% { background-color: #f3f4f6; } 
      100% { background-color: #f9fafb; } 
    }

    .modal-enter-active, .modal-leave-active { transition: opacity 0.3s ease; }
    .modal-enter-from, .modal-leave-to { opacity: 0; }
    .modal-content-enter-active, .modal-content-leave-active { transition: all 0.3s ease; }
    .modal-content-enter-from, .modal-content-leave-to { opacity: 0; transform: scale(0.95); }

    ::-webkit-scrollbar { width: 6px; height: 6px; }
    ::-webkit-scrollbar-track { background: #e5e7eb; border-radius: 10px; }
    ::-webkit-scrollbar-thumb { background: #9ca3af; border-radius: 10px; }
    ::-webkit-scrollbar-thumb:hover { background: #6b7280; }

    .dot-background-members { background-image: radial-gradient(circle at 1.5px 1.5px, rgba(107, 114, 128, 0.12) 1px, transparent 0); background-size: 22px 22px; animation: dot-drift-members 25s linear infinite; position: absolute; inset: 0; z-index: 0; }
    @keyframes dot-drift-members { 0% { background-position: 0 0, 11px 11px; } 100% { background-position: 22px 22px, 33px 33px; } }

    .relative.z-10 { position: relative; z-index: 10; }
    .sticky.z-20 { position: sticky; z-index: 20; }
    .fixed.z-50 { position: fixed; z-index: 50; }
    .font-mono { font-family: 'ui-monospace', 'SFMono-Regular', 'Menlo', 'Monaco', 'Consolas', "Liberation Mono", "Courier New", monospace; }
    </style>