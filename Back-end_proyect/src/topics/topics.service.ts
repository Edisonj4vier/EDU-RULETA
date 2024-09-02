import {
  BadRequestException,
  Injectable,
  InternalServerErrorException,
  Logger,
} from '@nestjs/common';
import { CreateTopicDto } from './dto/create-topic.dto';
import { UpdateTopicDto } from './dto/update-topic.dto';
import { PaginationDto } from 'src/common/dto/pagination.dto';
import { Repository } from 'typeorm';
import { Topic } from './entities/topic.entity';
import { InjectRepository } from '@nestjs/typeorm';

@Injectable()
export class TopicsService {
  private readonly logger = new Logger('TopicsService');
  constructor(
    @InjectRepository(Topic)
    private readonly topicRepository: Repository<Topic>,
  ) {}
  async create(createTopicDto: CreateTopicDto) {
    try {
      const topic = this.topicRepository.create({
        nombre: createTopicDto.nombre,
        descripcion: createTopicDto.descripcion,
        course: {
          id: createTopicDto.course_id,
        },
        url_video: createTopicDto.url_video,
        url_imagen: createTopicDto.url_imagen,
      });
      return await this.topicRepository.save(topic);
    } catch (error) {
      this.handleDBExceptions(error);
    }
  }

  async findAll(paginationDTO: PaginationDto) {
    try {
      const { limit = 10, offset = 0 } = paginationDTO;
      return await this.topicRepository.find({
        take: limit,
        skip: limit * offset,
      });
    } catch (error) {
      this.handleDBExceptions(error);
    }
  }

  async findAllByCourse(courseId: string, paginationDTO: PaginationDto) {
    try {
      const { limit = 5, offset = 0 } = paginationDTO;
      return await this.topicRepository.find({
        take: limit,
        skip: limit * offset,
        where: {
          course: { id: courseId },
        },
      });
    } catch (error) {
      this.handleDBExceptions(error);
    }
  }

  async findOne(id: string) {
    try {
      return await this.topicRepository.findOne({
        where: { id: id },
        relations: ['course'],
      });
    } catch (error) {
      this.handleDBExceptions(error);
    }
  }

  async update(id: string, updateTopicDto: UpdateTopicDto) {
    const topic = await this.topicRepository.update(id, {
      nombre: updateTopicDto.nombre,
      descripcion: updateTopicDto.descripcion,
    });
    return topic;
  }

  async remove(id: string) {
    try {
      return await this.topicRepository.delete(id);
    } catch (error) {
      this.handleDBExceptions(error);
    }
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
