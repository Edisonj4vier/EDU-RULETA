import { Injectable, Logger } from '@nestjs/common';
import { CreateSubjectDto } from './dto/create-subject.dto';
import { UpdateSubjectDto } from './dto/update-subject.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Subject } from './entities/subject.entity';
import { DataSource, Repository } from 'typeorm';

@Injectable()
export class SubjectService {
  private readonly logger = new Logger('SubjectsService');

  constructor(
    @InjectRepository(Subject)
    private readonly productRepository: Repository<Subject>,

    private readonly dataSource: DataSource,
  ) {}
  async create(createSubjectDto: CreateSubjectDto) {
    const subject = this.productRepository.create(createSubjectDto);
    return await this.productRepository.save(subject);
  }

  findAll() {}

  findOne(id: number) {
    return `This action returns a #${id} subject`;
  }

  update(id: number, updateSubjectDto: UpdateSubjectDto) {
    return `This action updates a #${id} subject`;
  }

  remove(id: number) {
    return `This action removes a #${id} subject`;
  }
}
