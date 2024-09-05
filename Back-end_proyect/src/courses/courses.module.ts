import { Module } from '@nestjs/common';
import { CoursesService } from './courses.service';
import { CoursesController } from './courses.controller';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Course } from './entities/course.entity';
import { AuthModule } from 'src/auth/auth.module';

@Module({
  controllers: [CoursesController],
  providers: [CoursesService],
  imports: [ConfigModule, TypeOrmModule.forFeature([Course]), AuthModule],
  exports: [TypeOrmModule],
})
export class CoursesModule {}
