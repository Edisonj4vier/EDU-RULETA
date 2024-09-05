import { Module } from '@nestjs/common';
import { StudentCourseService } from './student_course.service';
import { StudentCourseController } from './student_course.controller';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { StudentCourse } from './entities/student_course.entity';
import { AuthModule } from 'src/auth/auth.module';

@Module({
  controllers: [StudentCourseController],
  providers: [StudentCourseService],
  imports: [
    ConfigModule,
    TypeOrmModule.forFeature([StudentCourse]),
    AuthModule,
  ],
  exports: [TypeOrmModule],
})
export class StudentCourseModule {}
