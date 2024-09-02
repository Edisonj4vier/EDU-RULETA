import {
  BadRequestException,
  Injectable,
  InternalServerErrorException,
  Logger,
  NotFoundException,
} from '@nestjs/common';
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
  ) {}
  async create(createCourseDto: CreateCourseDto) {
    const course = this.productRepository.create(createCourseDto);
    return await this.productRepository.save(course);
  }

  async findAll(paginationDTO: PaginationDto) {
    const { limit = 10, offset = 0 } = paginationDTO;

    return await this.productRepository.find({
      take: limit,
      skip: limit * offset,
    });
  }

  async findAllByUser(userId: string, paginationDTO: PaginationDto) {
    const { limit = 5, offset = 0 } = paginationDTO;

    return await this.productRepository.find({
      take: limit,
      skip: limit * offset,
      where: {
        user: { id: userId },
      },
    });
  }

  async findOne(id: string) {
    const course = this.productRepository.find({
      where: { id: id },
      relations: ['user'],
    });
    if (!course) {
      throw new NotFoundException('Course not found');
    }
    return course;
  }

  async update(id: string, updateCourseDto: UpdateCourseDto) {
    const course = await this.productRepository.update(id, updateCourseDto);
    if (!course) {
      throw new NotFoundException('Course not found');
    }
    return course;
  }

  async remove(id: string) {
    return await this.productRepository.delete(id);
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
