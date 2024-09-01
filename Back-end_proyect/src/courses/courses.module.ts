import { Module } from '@nestjs/common';
import { CoursesService } from './courses.service';
import { CoursesController } from './courses.controller';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Course } from './entities/course.entity';

@Module({
  controllers: [CoursesController],
  providers: [CoursesService],
  imports: [ConfigModule, TypeOrmModule.forFeature([Course])],
  exports: [TypeOrmModule],
})
export class CoursesModule {}
