<?php

namespace Database\Seeders;

use App\Models\Roles;
use App\Models\Members;
use App\Models\Cabinets;
use App\Models\Divisions;
use App\Models\MemberDetails;
use Illuminate\Database\Seeder;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class MemberDetailsSeeder extends Seeder
{


    /**
     * 
     * Run the database seeds.
     */
    public function run(): void
    {
        $cabinet = Cabinets::first();
        $roles = Roles::all()->keyBy('name');
        $divisions = Divisions::all()->keyBy('name');

        $memberDetails = [
            [
                'member_name' => 'Abdurrahman Khairi',
                'role' => 'Chairperson',
                'division' => null,
                'batch' => '2023',
            ],
            [
                'member_name' => 'Filbert Sembiring Meliala',
                'role' => 'Vice Chairperson I',
                'division' => null,
                'batch' => '2023',
            ],
            [
                'member_name' => 'Leonardo Dos Santos',
                'role' => 'Vice Chairperson II',
                'division' => null,
                'batch' => '2023',
            ],
            [
                'member_name' => 'Moshe Dayan',
                'role' => 'Senior Treasurer',
                'division' => null,
                'batch' => '2023',
            ],
            [
                'member_name' => 'Elvia Aptanisa',
                'role' => 'Junior Treasurer',
                'division' => null,
                'batch' => '2024',
            ],
            [
                'member_name' => 'Michelle',
                'role' => 'Junior Treasurer',
                'division' => null,
                'batch' => '2024',
            ],
            [
                'member_name' => 'Desy Nursalsabila',
                'role' => 'Senior Secretary',
                'division' => null,
                'batch' => '2023',
            ],
            [
                'member_name' => 'Putri Zahara',
                'role' => 'Junior Secretary',
                'division' => null,
                'batch' => '2024',
            ],
            [
                'member_name' => 'Zuldan Fahrizal Rahman',
                'role' => 'Junior Secretary',
                'division' => null,
                'batch' => '2024',
            ],
            // Add more member details here...
        ];

        foreach ($memberDetails as $detail) {
            $member = Members::where('name', $detail['member_name'])->first();
            $role = $roles[$detail['role']];
            $division = $detail['division'] ? $divisions[$detail['division']] : null;

            MemberDetails::create([
                'member_id' => $member->id,
                'cabinet_id' => $cabinet->id,
                'division_id' => $division ? $division->id : null,
                'role_id' => $role->id,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
}
