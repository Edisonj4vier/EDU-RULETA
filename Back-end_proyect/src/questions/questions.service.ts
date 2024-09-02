import {
  BadRequestException,
  Injectable,
  InternalServerErrorException,
  Logger,
} from '@nestjs/common';
import { CreateQuestionDto } from './dto/create-question.dto';
import { UpdateQuestionDto } from './dto/update-question.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Question } from './entities/question.entity';
import { Repository } from 'typeorm';
import { Answer } from './entities/answer.entity';
import { PaginationDto } from 'src/common/dto/pagination.dto';

@Injectable()
export class QuestionsService {
  private readonly logger = new Logger('QuestionsService');

  constructor(
    @InjectRepository(Question)
    private readonly questionRepository: Repository<Question>,

    // private readonly dataSource: DataSource,
    @InjectRepository(Answer)
    private readonly answerRepository: Repository<Answer>,
  ) {}
  async create(createQuestionDto: CreateQuestionDto) {
    try {
      const question = this.questionRepository.create({
        ...createQuestionDto,
      });
      await this.questionRepository.save(question);

      // Create answers
      const answers = createQuestionDto.answers.map((answer) => {
        return this.answerRepository.create({
          ...answer,
          question,
        });
      });

      await this.answerRepository.save(answers);

      return {
        ...question,
        answers,
      };
    } catch (error) {
      this.handleDBExceptions(error);
    }
  }

  async findAllByTopic(topicId: string, paginationDto: PaginationDto) {
    const { limit = 10, offset = 0 } = paginationDto;
    return await this.questionRepository.find({
      take: limit,
      skip: limit * offset,
      where: {
        topic: { id: topicId },
      },
    });
  }

  async findOne(id: string) {
    return await this.questionRepository.findOne({
      where: { id: id },
      relations: ['answers'],
    });
  }

  async update(id: string, updateQuestionDto: UpdateQuestionDto) {
    try {
      await this.questionRepository.update(id, {
        ...updateQuestionDto,
      });

      // Update answers
      updateQuestionDto.answers.forEach(async (answer) => {
        await this.answerRepository.update(
          {
            id: answer.id,
          },
          {
            ...answer,
          },
        );
      });

      return await this.questionRepository.findOne({
        where: { id: id },
        relations: ['answers'],
      });
    } catch (error) {
      this.handleDBExceptions(error);
    }
  }

  async remove(id: string) {
    try {
      return await this.questionRepository.delete(id);
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
