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
                'name' => 'ER',
                'title' => 'External Relation',
                'description' => 'Responsible for handling external affairs and collaborations.',
                'image' => "https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg",
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name' => 'IR',
                'title' => 'Internal Relation',
                'description' => 'Manages internal affairs and maintains good relationships within the organization.',
                'image' => "https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg",
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name' => 'SAC',
                'title' => 'Student Academic and Competition',
                'description' => 'Focuses on academic development and competitions.',
                'image' => "https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg",
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name' => 'ICM',
                'title' => 'Informative and Creative Media',
                'description' => 'Handles media, publications, and creative content.',
                'image' => "https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg",
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name' => 'RNT',
                'title' => 'Research and Technology',
                'description' => 'Engages in research, development, and technology-related initiatives.',
                'image' => "https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg",
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name' => 'Technopreneur',
                'title' => 'Technopreneur',
                'description' => 'Combines technology and entrepreneurship for innovative solutions.',
                'image' => "https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg",
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name' => 'HRD',
                'title' => 'Human Resource and Development',
                'description' => 'Manages HR tasks, training, and development of members.',
                'image' => "https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg",
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name' => 'SPT',
                'title' => 'Student Passions and Talents',
                'description' => 'Encourages and supports students in pursuing their talents and interests.',
                'image' => "https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg",
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name' => 'BOD',
                'title' => 'Board of Director',
                'description' => 'Oversees the organization and its strategic direction.',
                'image' => "https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg",
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
