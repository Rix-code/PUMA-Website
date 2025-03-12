<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class CabinetsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $cabinets = [
            [
                'name' => 'Kaustav',
                'term_start' => '2024',
                'term_end' => '2025',
                'status' => 'active',
                'description' => 'PUMA Informatics Cabinet for the 2024-2025 academic year.',
                'created_at' => now(),
                'updated_at' => now(),
            ]
        ];

        DB::table('cabinets')->insert($cabinets);
        $this->command->info('Cabinets table seeded successfully!');
    }
}
