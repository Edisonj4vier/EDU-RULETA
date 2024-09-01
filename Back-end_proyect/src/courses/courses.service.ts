import { Injectable, Logger, NotFoundException } from '@nestjs/common';
import { CreateCourseDto } from './dto/create-course.dto';
import { UpdateCourseDto } from './dto/update-course.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Course } from './entities/course.entity';
import { DataSource, Repository } from 'typeorm';
import { PaginationDto } from 'src/common/dto/pagination.dto';
@Injectable()
export class CoursesService {
  private readonly logger = new Logger('CoursesService');

  constructor(
    @InjectRepository(Course)
    private readonly productRepository: Repository<Course>,

    private readonly dataSource: DataSource,
  ) {}
  create(createCourseDto: CreateCourseDto) {
    const course = this.productRepository.create(createCourseDto);
    return this.productRepository.save(course);
  }

  findAll(paginationDTO: PaginationDto) {
    const { limit = 10, offset = 0 } = paginationDTO;

    return this.productRepository.find({
      take: limit,
      skip: limit * offset,
    });
  }

  findAllByUser(userId: string, paginationDTO: PaginationDto) {
    const { limit = 5, offset = 0 } = paginationDTO;

    return this.productRepository.find({
      take: limit,
      skip: limit * offset,
      where: {
        user: { id: userId },
      },
    });
  }

  findOne(id: string) {
    const course = this.productRepository.find({
      where: { id: id },
      relations: ['user'],
    });
    if (!course) {
      throw new NotFoundException('Course not found');
    }
    return course;
  }

  update(id: string, updateCourseDto: UpdateCourseDto) {
    const course = this.productRepository.update(id, updateCourseDto);
  }

  remove(id: string) {
    return this.productRepository.delete(id);
  }
}
