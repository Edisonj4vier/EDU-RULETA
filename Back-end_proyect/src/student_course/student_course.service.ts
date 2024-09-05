import {
  BadRequestException,
  Injectable,
  InternalServerErrorException,
  Logger,
  NotFoundException,
} from '@nestjs/common';
import { CreateStudentCourseDto } from './dto/create-student_course.dto';
import { UpdateStudentCourseDto } from './dto/update-student_course.dto';
import { Repository } from 'typeorm';
import { StudentCourse } from './entities/student_course.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/auth/entities/auth.entity';

@Injectable()
export class StudentCourseService {
  private readonly logger = new Logger('StudentCourseService');

  constructor(
    @InjectRepository(StudentCourse)
    private readonly studentCourseSRepository: Repository<StudentCourse>,
  ) {}
  async create(createStudentCourseDto: CreateStudentCourseDto, user: User) {
    console.log('createStudentCourseDto', createStudentCourseDto);
    const studentCourse = this.studentCourseSRepository.create({
      puntuacion: createStudentCourseDto.puntuacion,
      user,
      course: { id: createStudentCourseDto.course_id },
    });
    return await this.studentCourseSRepository.save(studentCourse);
  }

  async findAll() {
    return `This action returns all studentCourse`;
  }

  async findOne(id: string) {
    try {
      const studentCourse = await this.studentCourseSRepository.findOne({
        where: { id },
        relations: ['course', 'course.topics'],
      });

      if (!studentCourse) {
        throw new NotFoundException('StudentCourse not found');
      }
      return studentCourse;
    } catch (error) {
      this.handleDBExceptions(error);
    }
  }

  async update(id: string, updateStudentCourseDto: UpdateStudentCourseDto) {
    const studentCourse = await this.findOne(id);
    try {
      this.studentCourseSRepository.merge(
        studentCourse,
        updateStudentCourseDto,
      );
      return await this.studentCourseSRepository.save(studentCourse);
    } catch (error) {
      this.handleDBExceptions(error);
    }
  }

  async remove(id: string) {
    const studentCourse = await this.studentCourseSRepository.findOne({
      where: { id },
    });
  }

  async findCoursesByStudent(user: User) {
    try {
      const studentCourses = await this.studentCourseSRepository.find({
        where: { user: { id: user.id } },
        relations: ['course'],
      });

      if (!studentCourses) {
        throw new NotFoundException('StudentCourse not found');
      }

      return studentCourses.map((sc) => {
        return {
          id: sc.id,
          course: sc.course,
          puntuation: sc.puntuacion,
          inscriptionDate: sc.fecha_inscripcion,
        };
      });
    } catch (error) {
      this.handleDBExceptions(error);
    }
  }

  async findCourseDetailsForStudent(user: User, courseId: string) {
    const studentCourse = await this.studentCourseSRepository.findOne({
      where: { user: { id: user.id }, course: { id: courseId } },
      relations: ['course', 'course.topics'],
    });

    if (!studentCourse) {
      throw new NotFoundException('Student is not registered in this course');
    }

    return {
      course: studentCourse.course,
      puntuacion: studentCourse.puntuacion,
      fecha_inscripcion: studentCourse.fecha_inscripcion,
      topics: studentCourse.course.topics,
    };
  }

  private handleDBExceptions(error: any) {
    if (error.code === '23505') {
      throw new BadRequestException(error.detail);
    }

    this.logger.error(error.message);
    throw new InternalServerErrorException(
      'Unexpected error. check server logs',
    );
  }
}
