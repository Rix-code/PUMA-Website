<script setup lang="ts">
import { ref, computed, onMounted, watch } from 'vue'
import { useRoute } from 'vue-router'
import Navbar from '../Navbar.vue'
import Footer from '../Footer.vue'

interface Division {
    name: string
    title: string
    image: string
    description: string
}

interface Member {
    id: number
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

const route = useRoute()
const selectedDivision = ref<string>('all')
const selectedCabinet = ref<string>('all')
const searchQuery = ref<string>('')
const isLoading = ref<boolean>(true)
const currentPage = ref<number>(1)
const itemsPerPage = ref<number>(12)
const selectedMember = ref<Member | null>(null)
const isModalOpen = ref<boolean>(false)

const divisions: Division[] = [
    {
        name: 'BOD',
        title: 'Board of Directors',
        image: 'DSC_0926.JPG', 
        description: 'lorem'
    },
    {
        name: 'RNT',
        title: 'Research and Technology',
        image: 'https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg',
        description: 'lorem'
    },
    {
        name: 'HRD',
        title: 'Human Resources Development',
        image: 'hrd.JPG',
        description: 'lorem'
    },
    {
        name: 'ICM',
        title: 'Information and Creative Media',
        image: 'https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg',
        description: 'lorem'
    },
    {
        name: 'IR',
        title: 'Internal Relations',
        image: 'https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg',
        description: 'lorem'
    },
    {
        name: 'ER',
        title: 'External Relations',
        image: 'https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg',
        description: 'lorem'
    },
    {
        name: 'SAC',
        title: 'Student Academic & Competition',
        image: 'https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg',
        description: 'lorem'
    },
    {
        name: 'SPT',
        title: 'Student Passions & Talents',
        image: 'https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg',
        description: 'lorem'
    },
    {
        name: 'TECHNOPRENEUR',
        title: 'Technopreneur',
        image: 'https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg',
        description: 'lorem'
    }
]

const cabinets = ['Kaustav', 'Kopi']

const memberAvatars = [
    'https://i.pinimg.com/474x/2d/66/90/2d669016a3e3f5316b0589741e8ca834.jpg',
    'https://i.pinimg.com/474x/9c/58/0a/9c580ad4644fffdb9bf4eedb7b61eec2.jpg',
    'https://i.pinimg.com/474x/d5/14/5e/d5145e0284dcf8b0d828b78d2ebeaacc.jpg',
    'https://i.pinimg.com/474x/a1/da/a6/a1daa6f2d1416629a2af13989ebcaa9f.jpg',
    'https://i.pinimg.com/474x/8f/72/31/8f723127ce24c5983fd21d6fa84733a8.jpg',
    'https://i.pinimg.com/474x/1c/02/5f/1c025fa699fe372269009dad8681ca9e.jpg'
]

const generateMembers = (): Member[] => {
    const members: Member[] = [
        {
            id: 1,
            name: "Abdurrahman Khairi",
            email: "-",
            position: "Chairperson",
            cabinet: "Kaustav Cabinet",
            batch: "2023",
            division: "BOD",
            avatar: "khairi.JPG", // Replace with actual image path or URL
            instagram: "https://instagram.com/",
            linkedin: "https://linkedin.com/in/",
            personalDescription: "-"
        },
        {
            id: 2,
            name: "Filbert Sembiring Meliala",
            email: "-",
            position: "Vice Chairperson 1",
            cabinet: "Kaustav Cabinet",
            batch: "2023",
            division: "BOD",
            avatar: "filbert.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 3,
            name: "Leonardo Dos Santos",
            email: "-",
            position: "Vice Chairperson 2",
            cabinet: "Kaustav Cabinet",
            batch: "2023",
            division: "BOD",
            avatar: "leonardo.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 4,
            name: "Moshe Dayan",
            email: "-",
            position: "Senior Treasurer",
            cabinet: "Kaustav Cabinet",
            batch: "2023",
            division: "BOD",
            avatar: "moshe.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 5,
            name: "Elvia Aptanisa",
            email: "-",
            position: "Junior Treasurer",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "BOD",
            avatar: "elvi.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 6,
            name: "Michelle",
            email: "-",
            position: "Junior Treasurer",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "BOD",
            avatar: "michelle.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 7,
            name: "Desy Nursalsabila",
            email: "-",
            position: "Senior Secretary",
            cabinet: "Kaustav Cabinet",
            batch: "2023",
            division: "BOD",
            avatar: "desy.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 8,
            name: "Putri Zahara",
            email: "-",
            position: "Junior Secretary",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "BOD",
            avatar: "putri.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 9,
            name: "Zuldan Fahrizal Rahman",
            email: "-",
            position: "Junior Secretary",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "BOD",
            avatar: "zuldan.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 10,
            name: "Isya Maghfira Zalfa",
            email: "-",
            position: "Head of External Relation",
            cabinet: "Kaustav Cabinet",
            batch: "2023",
            division: "ER",
            avatar: "cica.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 11,
            name: "Sarahwati",
            email: "-",
            position: "Vice of External Relation",
            cabinet: "Kaustav Cabinet",
            batch: "2023",
            division: "ER",
            avatar: "sarah.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 12,
            name: "Shanty",
            email: "-",
            position: "Member of External Relation",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "ER",
            avatar: "shanty.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 13,
            name: "Naufal Rizki Pinugroho",
            email: "-",
            position: "Member of External Relation",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "ER",
            avatar: "nopal.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 14,
            name: "Made Mas Pradnya Prabawa",
            email: "-",
            position: "Member of External Relation",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "ER",
            avatar: "prad.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 15,
            name: "Gideon Anggara Siagian",
            email: "-",
            position: "Member of External Relation",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "ER",
            avatar: "gideon.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 16,
            name: "Bianca Vallerie",
            email: "-",
            position: "Head of Internal Relation",
            cabinet: "Kaustav Cabinet",
            batch: "2023",
            division: "IR",
            avatar: "bianca.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 17,
            name: "Abigail Tiara Larasati",
            email: "-",
            position: "Vice of Internal Relation",
            cabinet: "Kaustav Cabinet",
            batch: "2023",
            division: "IR",
            avatar: "bigel.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 18,
            name: "Johana Veronica Setiawan",
            email: "-",
            position: "Member of Internal Relation",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "IR",
            avatar: "joana.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 19,
            name: "Muhammad Dzaki Abrar",
            email: "-",
            position: "Member of Internal Relation",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "IR",
            avatar: "dzaki.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 20,
            name: "Zain Akbar",
            email: "-",
            position: "Member of Internal Relation",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "IR",
            avatar: "akbar.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 21,
            name: "hana Khairunnisa Nabiilah",
            email: "-",
            position: "Head of Student Academic and Competition",
            cabinet: "Kaustav Cabinet",
            batch: "2023",
            division: "SAC",
            avatar: "hana.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 22,
            name: "Sarah Kimberly Fischer",
            email: "-",
            position: "Vice of Student Academy and Competition",
            cabinet: "Kaustav Cabinet",
            batch: "2023",
            division: "SAC",
            avatar: "kim.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 23,
            name: "Lutfi Maulana",
            email: "-",
            position: "Member of Student Academy and Competition",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "SAC",
            avatar: "lutfi.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 24,
            name: "Wilbert Leonard Harriman",
            email: "-",
            position: "Member of Student Academy and Competition",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "SAC",
            avatar: "wilbert.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 25,
            name: "Yasmin Raihanah Inayudha",
            email: "-",
            position: "Member of Student Academy and Competition",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "SAC",
            avatar: "yasmin.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 26,
            name: "Cut Kheysa Sakbania",
            email: "-",
            position: "Member of Student Academy and Competition",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "SAC",
            avatar: "cut.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 27,
            name: "Made Mahatti Prayascita Chandra",
            email: "-",
            position: "Head of Information and Creative Media",
            cabinet: "Kaustav Cabinet",
            batch: "2023",
            division: "ICM",
            avatar: "mahatti.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 28,
            name: "Nadifah Aulia Rahmani",
            email: "-",
            position: "Vice of Media Information",
            cabinet: "Kaustav Cabinet",
            batch: "2023",
            division: "ICM",
            avatar: "nadifah.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 29,
            name: "Muhammad Afdal Fikri",
            email: "-",
            position: "Member of Media Infromation",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "ICM",
            avatar: "afdal.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        }, // in 30 database is Gamma, i change to sort tidy; 31 is naila; 32 is azqa
        {
            id: 30,
            name: "Naila Olivia",
            email: "-",
            position: "Member of Media Infromation",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "ICM",
            avatar: "olivia.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 31,
            name: "Azqa Difani Akbar",
            email: "-",
            position: "Vice of Creative Media",
            cabinet: "Kaustav Cabinet",
            batch: "2023",
            division: "ICM",
            avatar: "azka.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 32,
            name: "Gamma Ahmad Zaki Kurnia Budihardjo",
            email: "-",
            position: "Member of Creative Media",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "ICM",
            avatar: "gamma.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 33,
            name: "Almira Shinta Aulia",
            email: "-",
            position: "Member of Creative Media",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "ICM",
            avatar: "almira.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 34,
            name: "Richie Obasa",
            email: "-",
            position: "Member of Creative Media",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "ICM",
            avatar: "richie.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 35,
            name: "Gabriel Hamonangan Lumban Tobing",
            email: "-",
            position: "Member of Creative Media",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "ICM",
            avatar: "hamongan.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 36,
            name: "Raisya Eka Putri",
            email: "-",
            position: "Member of Creative Media",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "ICM",
            avatar: "raisya.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 37,
            name: "Kevin Syonin",
            email: "-",
            position: "Member of Creative Media",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "ICM",
            avatar: "kevin.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 38,
            name: "Dewa Anggara Satria Pratama",
            email: "-",
            position: "Member of Creative Media",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "ICM",
            avatar: "dewa.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 39,
            name: "Rix Valdo",
            email: "-",
            position: "Head of Research and Technology",
            cabinet: "Kaustav Cabinet",
            batch: "2023",
            division: "RNT",
            avatar: "avatar2.png",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 40,
            name: "Jason Anthony Wibowo",
            email: "-",
            position: "Vice of Research and Technology",
            cabinet: "Kaustav Cabinet",
            batch: "2023",
            division: "RNT",
            avatar: "avatar2.png",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 41,
            name: "Muhammad Haikal Islami",
            email: "-",
            position: "Member of Research and Technology",
            cabinet: "Kaustav Cabinet",
            batch: "2023",
            division: "RNT",
            avatar: "avatar2.png",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 42,
            name: "Briant Jasper",
            email: "-",
            position: "Member of Research and Technology",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "RNT",
            avatar: "avatar2.png",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 43,
            name: "Keira Nevrada Lay",
            email: "-",
            position: "Member of Research and Technology",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "RNT",
            avatar: "avatar2.png",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 44,
            name: "Janet Dewi Evangeline",
            email: "-",
            position: "Member of Research and Technology",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "RNT",
            avatar: "avatar2.png",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 45,
            name: "Nisrina Izza Nur Aisyah",
            email: "-",
            position: "Member of Research and Technology",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "RNT",
            avatar: "avatar2.png",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 46,
            name: "Ubaidillah Al-Azhar",
            email: "-",
            position: "Head of Technopreneur",
            cabinet: "Kaustav Cabinet",
            batch: "2023",
            division: "TECHNOPRENEUR",
            avatar: "ubai.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 47,
            name: "Salsa Ica Indriani",
            email: "-",
            position: "Vice of Technopreneur",
            cabinet: "Kaustav Cabinet",
            batch: "2023",
            division: "TECHNOPRENEUR",
            avatar: "ica.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 48,
            name: "Navisa Ersa Sabina",
            email: "-",
            position: "Member of Technopreneur",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "TECHNOPRENEUR",
            avatar: "sasa.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 49,
            name: "Michael Bryan Mandey",
            email: "-",
            position: "Member of Technopreneur",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "TECHNOPRENEUR",
            avatar: "michael.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 50,
            name: "Nailha Sakhila Dewi",
            email: "-",
            position: "Member of Technopreneur",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "TECHNOPRENEUR",
            avatar: "nailha.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 51,
            name: "Joy Adelia Sihombing",
            email: "-",
            position: "Head of Human Resources Development",
            cabinet: "Kaustav Cabinet",
            batch: "2023",
            division: "HRD",
            avatar: "joy.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 52,
            name: "Intan Kumala Pasya",
            email: "-",
            position: "Vice of Human Resources Development",
            cabinet: "Kaustav Cabinet",
            batch: "2023",
            division: "HRD",
            avatar: "intan.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 53,
            name: "Tio Muhammad Rizky",
            email: "-",
            position: "Member of Human Resources Development",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "HRD",
            avatar: "tio.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 54,
            name: "Angelina Yolanda Christin Lubis",
            email: "-",
            position: "Member of Human Resources Development",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "HRD",
            avatar: "angel.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 55,
            name: "Ernest Teo",
            email: "-",
            position: "Head of Student Passions and Talents",
            cabinet: "Kaustav Cabinet",
            batch: "2023",
            division: "SPT",
            avatar: "ernest.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 56,
            name: "Rivan Meinaki",
            email: "-",
            position: "Vice of Student Passions and Talents",
            cabinet: "Kaustav Cabinet",
            batch: "2023",
            division: "SPT",
            avatar: "rivan.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 57,
            name: "Wisnu Alfian Nur Ashar",
            email: "-",
            position: "Member of Student Passions and Talents",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "SPT",
            avatar: "wisnu.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 58,
            name: "Fauzan Fajri",
            email: "-",
            position: "Member of Student Passions and Talents",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "SPT",
            avatar: "fauzan.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        {
            id: 59,
            name: "Qwyn Celine Djimondo",
            email: "-",
            position: "Member of Student Passions and Talents",
            cabinet: "Kaustav Cabinet",
            batch: "2024",
            division: "SPT",
            avatar: "qwin.JPG",
            instagram: "https://instagram.com/martha_nielsen",
            linkedin: "https://linkedin.com/in/martha-nielsen",
            personalDescription: "-"
        },
        // Add more member objects below as needed
    ]

    return members
}

const allMembers = ref<Member[]>([])
const filteredMembers = computed(() => {
    let result = [...allMembers.value]

    if (selectedDivision.value !== 'all') {
        result = result.filter(member => member.division === selectedDivision.value)
    }

    if (selectedCabinet.value !== 'all') {
        result = result.filter(member => member.cabinet === selectedCabinet.value)
    }

    if (searchQuery.value) {
        const query = searchQuery.value.toLowerCase()
        result = result.filter(member =>
            member.name.toLowerCase().includes(query) ||
            member.email.toLowerCase().includes(query) ||
            member.position.toLowerCase().includes(query)
        )
    }

    return result
})

const totalPages = computed(() => Math.ceil(filteredMembers.value.length / itemsPerPage.value))
const paginatedMembers = computed(() => {
    const start = (currentPage.value - 1) * itemsPerPage.value
    const end = start + itemsPerPage.value
    return filteredMembers.value.slice(start, end)
})

const goToPage = (pageNumber: number) => {
    currentPage.value = pageNumber
    window.scrollTo({ top: 0, behavior: 'smooth' })
}

const getDivisionTitle = (code: string) => {
    const division = divisions.find(d => d.name === code)
    return division ? division.title : code
}

const openModal = (member: Member) => {
    selectedMember.value = member
    isModalOpen.value = true
}

const closeModal = () => {
    isModalOpen.value = false
    selectedMember.value = null
}

onMounted(() => {
    setTimeout(() => {
        allMembers.value = generateMembers()
        isLoading.value = false
    }, 800)
})

// Watch for changes in the route query
watch(
    () => route.query.division,
    (newDivision) => {
        if (newDivision) {
            selectedDivision.value = newDivision as string
        } else {
            selectedDivision.value = 'all'
        }
    },
    { immediate: true }
)
</script>

<template>
    <Navbar />
    <div class="min-h-screen pt-20 bg-gray-50">
        <section class="py-6 bg-white border-b border-gray-200">
            <div class="container px-4 mx-auto">
                <div class="flex flex-col space-y-4 md:space-y-0 md:flex-row md:space-x-6">
                    <div class="flex-1">
                        <div class="relative">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                                <svg class="w-4 h-4 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none"
                                    viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                                </svg>
                            </span>
                            <input type="text" v-model="searchQuery" placeholder="Search by name, email, position..."
                                class="w-full py-3 pl-10 pr-4 text-sm transition-all bg-gray-100 border-0 rounded-lg focus:ring-2 focus:ring-black focus:outline-none" />
                        </div>
                    </div>

                    <div class="md:w-64">
                        <div class="relative">
                            <select v-model="selectedDivision"
                                class="w-full py-3 pl-4 pr-10 text-sm transition-all bg-gray-100 border-0 rounded-lg appearance-none focus:ring-2 focus:ring-black focus:outline-none">
                                <option value="all">All Divisions</option>
                                <option v-for="division in divisions" :key="division.name" :value="division.name">
                                    {{ division.title }}
                                </option>
                            </select>
                            <div class="absolute inset-y-0 right-0 flex items-center px-3 pointer-events-none">
                                <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor"
                                    viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M19 9l-7 7-7-7"></path>
                                </svg>
                            </div>
                        </div>
                    </div>

                    <div class="md:w-64">
                        <div class="relative">
                            <select v-model="selectedCabinet"
                                class="w-full py-3 pl-4 pr-10 text-sm transition-all bg-gray-100 border-0 rounded-lg appearance-none focus:ring-2 focus:ring-black focus:outline-none">
                                <option value="all">All Cabinets</option>
                                <option v-for="cabinet in cabinets" :key="cabinet" :value="cabinet">
                                    {{ cabinet }}
                                </option>
                            </select>
                            <div class="absolute inset-y-0 right-0 flex items-center px-3 pointer-events-none">
                                <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor"
                                    viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M19 9l-7 7-7-7"></path>
                                </svg>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="py-12">
            <div class="container px-4 mx-auto">
                <div class="flex items-center justify-between mb-8">
                    <h2 class="text-xl font-bold text-gray-900">
                        <span class="mr-2">Members</span>
                        <span class="px-2 py-1 text-xs text-gray-600 bg-gray-100 border border-gray-200 rounded-full">
                            {{ isLoading ? '...' : filteredMembers.length }} results
                        </span>
                    </h2>
                    <div v-if="!isLoading" class="text-sm text-gray-600">
                        Showing page {{ currentPage }} of {{ totalPages || 1 }}
                    </div>
                </div>

                <div v-if="isLoading" class="flex items-center justify-center py-20">
                    <div class="w-12 h-12 border-t-2 border-b-2 border-black rounded-full animate-spin"></div>
                </div>

                <div v-else>
                    <div v-if="filteredMembers.length === 0"
                        class="py-20 text-center bg-gray-100 border border-gray-200 border-dashed rounded-lg">
                        <svg class="w-16 h-16 mx-auto text-gray-400" fill="none" stroke="currentColor"
                            viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M12 21a9 9 0 110-18 9 9 0 010 18z">
                            </path>
                        </svg>
                        <h3 class="mt-4 text-lg font-semibold text-gray-700">No members found</h3>
                        <p class="mt-2 text-sm text-gray-500">Try adjusting your filters</p>
                    </div>

                    <div v-else class="grid grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
                        <div v-for="member in paginatedMembers" :key="member.id"
                            class="bg-white rounded-lg overflow-hidden border border-gray-200 transition-all duration-200 hover:translate-y-[-4px] hover:shadow-lg"
                            @click="openModal(member)">

                            <div class="flex items-start p-4 border-b border-gray-100">
                                <div class="relative w-16 h-16 mr-4">
                                    <img :src="member.avatar" :alt="member.name"
                                        class="object-cover w-16 h-16 border-2 border-gray-200 rounded-full"
                                        loading="lazy" />
                                </div>

                                <div class="flex-1">
                                    <h3 class="text-lg font-semibold leading-tight text-gray-900">{{ member.name }}</h3>
                                    <p class="text-sm text-gray-600 mt-0.5">{{ member.position }}</p>
                                    <div class="flex gap-1 mt-1">
                                        <span
                                            class="inline-flex items-center px-2 py-0.5 text-xs font-medium bg-gray-100 text-gray-800 rounded">
                                            {{ member.division }}
                                        </span>
                                        <span
                                            class="inline-flex items-center px-2 py-0.5 text-xs font-medium bg-gray-100 text-gray-800 rounded">
                                            {{ member.cabinet }}
                                        </span>
                                    </div>
                                </div>

                                <div class="transition-opacity opacity-0 group-hover:opacity-100">
                                    <button class="p-2 rounded-full hover:bg-gray-100">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-gray-500"
                                            viewBox="0 0 20 20" fill="currentColor">
                                            <path
                                                d="M2.003 5.884L10 9.882l7.997-3.998A2 2 0 0016 4H4a2 2 0 00-1.997 1.884z" />
                                            <path d="M18 8.118l-8 4-8-4V14a2 2 0 002 2h12a2 2 0 002-2V8.118z" />
                                        </svg>
                                    </button>
                                </div>
                            </div>

                            <div class="p-4 bg-gray-50">
                                <p class="mb-2 text-sm text-gray-600 truncate">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="inline w-4 h-4 mr-1 text-gray-500"
                                        fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                                    </svg>
                                    {{ member.email }}
                                </p>
                                <button
                                    class="w-full py-2 text-sm font-medium text-center text-gray-800 transition-colors bg-gray-100 rounded-md hover:bg-gray-200">
                                    View Profile
                                </button>
                            </div>
                        </div>
                    </div>

                    <div v-if="totalPages > 1" class="flex justify-center mt-10">
                        <div class="flex space-x-1">
                            <button @click="goToPage(currentPage - 1)" :disabled="currentPage === 1"
                                class="px-4 py-2 text-sm text-gray-700 transition-colors border border-gray-200 rounded-lg disabled:opacity-50 disabled:cursor-not-allowed hover:bg-gray-100">
                                Previous
                            </button>

                            <template v-if="totalPages <= 7">
                                <button v-for="page in totalPages" :key="page" @click="goToPage(page)" :class="[
                                    'px-4 py-2 text-sm border rounded-lg transition-colors',
                                    currentPage === page
                                        ? 'bg-black text-white border-black'
                                        : 'border-gray-200 hover:bg-gray-100 text-gray-700'
                                ]">
                                    {{ page }}
                                </button>
                            </template>

                            <template v-else>
                                <button @click="goToPage(1)" :class="[
                                    'px-4 py-2 text-sm border rounded-lg transition-colors',
                                    currentPage === 1
                                        ? 'bg-black text-white border-black'
                                        : 'border-gray-200 hover:bg-gray-100 text-gray-700'
                                ]">
                                    1
                                </button>

                                <span v-if="currentPage > 3" class="px-4 py-2 text-sm text-gray-400">...</span>

                                <template v-for="pageNum in totalPages" :key="pageNum">
                                    <button
                                        v-if="pageNum !== 1 && pageNum !== totalPages && Math.abs(currentPage - pageNum) <= 1"
                                        @click="goToPage(pageNum)" :class="[
                                            'px-4 py-2 text-sm border rounded-lg transition-colors',
                                            currentPage === pageNum
                                                ? 'bg-black text-white border-black'
                                                : 'border-gray-200 hover:bg-gray-100 text-gray-700'
                                        ]">
                                        {{ pageNum }}
                                    </button>
                                </template>

                                <span v-if="currentPage < totalPages - 2"
                                    class="px-4 py-2 text-sm text-gray-400">...</span>

                                <button @click="goToPage(totalPages)" :class="[
                                    'px-4 py-2 text-sm border rounded-lg transition-colors',
                                    currentPage === totalPages
                                        ? 'bg-black text-white border-black'
                                        : 'border-gray-200 hover:bg-gray-100 text-gray-700'
                                ]">
                                    {{ totalPages }}
                                </button>
                            </template>

                            <button @click="goToPage(currentPage + 1)" :disabled="currentPage === totalPages"
                                class="px-4 py-2 text-sm text-gray-700 transition-colors border border-gray-200 rounded-lg disabled:opacity-50 disabled:cursor-not-allowed hover:bg-gray-100">
                                Next
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <Footer />

    <div v-if="isModalOpen"
        class="fixed inset-0 z-50 flex items-center justify-center transition-all duration-300 bg-black/30 backdrop-blur-sm"
        @click.self="closeModal">
        <div class="relative w-full max-w-4xl mx-4 overflow-hidden transition-all duration-500 transform bg-white shadow-2xl rounded-xl"
            :class="{ 'scale-100 opacity-100': isModalOpen, 'scale-95 opacity-0': !isModalOpen }"
            :style="{ boxShadow: '0 10px 40px rgba(0, 0, 0, 0.2), 0 0 0 1px rgba(0, 0, 0, 0.05)' }">

            <div class="absolute top-0 left-0 right-0 h-1 bg-black"></div>

            <button @click="closeModal"
                class="absolute z-10 flex items-center justify-center w-10 h-10 transition-all duration-300 bg-gray-100 rounded-full hover:bg-gray-200 top-4 right-4">
                <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-gray-700" viewBox="0 0 24 24" fill="none"
                    stroke="currentColor" stroke-width="2">
                    <line x1="18" y1="6" x2="6" y2="18"></line>
                    <line x1="6" y1="6" x2="18" y2="18"></line>
                </svg>
            </button>

            <div class="p-6 sm:p-8">
                <div v-if="selectedMember" class="space-y-6">
                    <div class="flex flex-col items-center space-y-4 sm:flex-row sm:space-y-0 sm:space-x-6">
                        <img :src="selectedMember.avatar" :alt="selectedMember.name"
                            class="object-cover w-32 h-32 rounded-lg shadow-md sm:w-40 sm:h-40" />

                        <div class="text-center sm:text-left">
                            <h3 class="text-2xl font-bold text-gray-900">{{ selectedMember.name }}</h3>
                            <p class="text-gray-600">{{ selectedMember.email }}</p>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 gap-4 sm:grid-cols-2">
                        <div>
                            <p class="text-sm text-gray-500">Position</p>
                            <p class="font-semibold text-gray-700">{{ selectedMember.position }}</p>
                        </div>
                        <div>
                            <p class="text-sm text-gray-500">Cabinet</p>
                            <p class="font-semibold text-gray-700">{{ selectedMember.cabinet }}</p>
                        </div>
                        <div>
                            <p class="text-sm text-gray-500">Batch</p>
                            <p class="font-semibold text-gray-700">{{ selectedMember.batch }}</p>
                        </div>
                        <div>
                            <p class="text-sm text-gray-500">Division</p>
                            <p class="font-semibold text-gray-700">{{ getDivisionTitle(selectedMember.division) }}</p>
                        </div>
                    </div>

                    <div>
                        <p class="text-sm text-gray-500">Personal Description</p>
                        <p class="text-gray-700">{{ selectedMember.personalDescription }}</p>
                    </div>

                    <div class="flex justify-center space-x-4 sm:justify-start">
                        <a :href="selectedMember.instagram" target="_blank" class="text-gray-500 hover:text-gray-700">
                            <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6" fill="currentColor"
                                viewBox="0 0 24 24">
                                <path
                                    d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z" />
                            </svg>
                        </a>
                        <a :href="selectedMember.linkedin" target="_blank" class="text-gray-500 hover:text-gray-700">
                            <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6" fill="currentColor"
                                viewBox="0 0 24 24">
                                <path
                                    d="M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z" />
                            </svg>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.grid-lines {
    background-image:
        linear-gradient(to right, rgba(0, 0, 0, 0.05) 1px, transparent 1px),
        linear-gradient(to bottom, rgba(0, 0, 0, 0.05) 1px, transparent 1px);
    background-size: 20px 20px;
}

footer {
    box-shadow: 0 -10px 30px rgba(0, 0, 0, 0.05);
}
</style>