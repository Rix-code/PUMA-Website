<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class MembersSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $members = [
            ['Abdurrahman Khairi'], ['Filbert Sembiring Meliala'], ['Leonardo Dos Santos'],
            ['Moshe Dayan'], ['Elvia Aptanisa'], ['Michelle'], ['Desy Nursalsabila'],
            ['Putri Zahara'], ['Zuldan Fahrizal Rahman'], ['Isya Maghfira Zalfa'],
            ['Sarahwati'], ['Shanty'], ['Naufal Rizki Pinugroho'], ['Made Mas Pradnya Prabawa'],
            ['Gideon Anggara Siagian'], ['Bianca Vallerie'], ['Abigail Tiara Larasati'],
            ['Johana Veronica Setiawan'], ['Muhammad Dzaki Abrar'], ['Zain Akbar'],
            ['Hana Khairunnisa Nabiilah'], ['Sarah Kimberly Fischer'], ['Lutfi Maulana'],
            ['Wilbert Leonard Harriman'], ['Yasmin Raihanah Inayudha'], ['Cut Kheysa Sakbania'],
            ['Made Mahatti Prayascita Chandra'], ['Nadifah Aulia Rahmani'], ['Muhammad Afdal Fikri'],
            ['Gamma Ahmad Zaki Kurnia Budihardjo'], ['Naila Olivia'], ['Azqa Difani Akbar'],
            ['Almira Shinta Aulia'], ['Richie Obhasa'], ['Gabriel Hamonangan Lumban Tobing'],
            ['Raisya Eka Putri'], ['Kevin Syonin'], ['Dewa Anggara Satria Pratama'], ['Rix Valdo'],
            ['Jason Anthony Wibowo'], ['Muhammad Haikal Islami'], ['Briant Jasper'],
            ['Keira Nevrada Lay'], ['Janet Dewi Evangeline'], ['Nisrina Izza Nur Aisyah'],
            ['Ubaidillah Al-Azhar'], ['Salsa Ica Indriani'], ['Navisa Ersa Sabina'],
            ['Michael Bryan Mandey'], ['Nailha Sakhila Dewi'], ['Joy Adelia Sihombing'],
            ['Intan Kumala Pasya'], ['Tio Muhammad Rizky'], ['Angelina Yolanda Christin Lubis'],
            ['Ernest Teo'], ['Rivan Meinaki'], ['Wisnu Alfian Nur Ashar'], ['Fauzan Fajri'],
            ['Qwyn Celine Djimondo']
        ];

        $data = array_map(fn($member) => [
            'name' => $member[0],
            'batch' => '-',
            'email' => strtolower(str_replace(' ', '', $member[0])) . '@example.com',
            'phone' => NULL,
            'password' => Hash::make('password'),
            'role' => 'Member',
            'status' => 'current',
            'joined_at' => Carbon::now()->toDateString(),
            'left_at' => NULL,
            'profile_image' => NULL,
            'created_at' => now(),
            'updated_at' => now()
        ], $members);

        DB::table('members')->insert($data);

        $this->command->info('Members table seeded successfully!');
    }
}
