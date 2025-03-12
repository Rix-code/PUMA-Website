<?php

namespace Database\Seeders;

use App\Models\Divisions;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DivisionsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('divisions')->insert([
            [
                'name' => 'External Relation',
                'description' => 'Responsible for handling external affairs and collaborations.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name' => 'Internal Relation',
                'description' => 'Manages internal affairs and maintains good relationships within the organization.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name' => 'Student Academic and Competition',
                'description' => 'Focuses on academic development and competitions.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name' => 'Informative and Creative Media',
                'description' => 'Handles media, publications, and creative content.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name' => 'Research and Technology',
                'description' => 'Engages in research, development, and technology-related initiatives.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name' => 'Technopreneur',
                'description' => 'Combines technology and entrepreneurship for innovative solutions.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name' => 'Human Resource and Development',
                'description' => 'Manages HR tasks, training, and development of members.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name' => 'Student Passions and Talents',
                'description' => 'Encourages and supports students in pursuing their talents and interests.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name' => 'Board of Director',
                'description' => 'Oversees the organization and its strategic direction.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
